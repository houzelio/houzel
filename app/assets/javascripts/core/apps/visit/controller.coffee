import { AppChan, ObjChan } from 'channels'
import { showView } from 'helpers/layout-region'
import { Visit, Patient, MclHistory } from 'entities/index'
import Syphon from 'backbone.syphon'
import FormView from './form-view'

Controller =
  newVisit: () ->
    visit = Visit.create()

    ObjChan.request("when:fetched", visit, =>
      view = @_getFormView(visit)
      view.on('visit:select:patient', @onVisitSelectPatient)
      showView(view)
    )

    return

  editVisit: (id) ->
    visit = Visit.get(id)
    mcl_histories = MclHistory.getList({ visit_id: id })

    ObjChan.request("when:fetched", [visit, mcl_histories], =>
      view = @_getFormView(visit, true)
      view.mclHistoryCollection = mcl_histories
      showView(view)
    )

    return

  _getFormView: (model, deleteOption) ->
    view = new FormView {model: model}

    view.on('visit:save', @onVisitSave)
    if deleteOption
      view.on('visit:confirm:delete', @onVisitConfirmDelete)

    view

  onVisitSelectPatient: (view, id) ->
    patient = Patient.get(id)
    mcl_histories = MclHistory.getList({ patient_id: id })

    ObjChan.request("when:fetched", [patient, mcl_histories], =>
      patient = new Patient.create({patient: _.clone(patient.attributes)})
      view.showPatientInfo(patient, mcl_histories)
    )

  onVisitSave: (view) ->
    model = view.model
    if !model.isValid(true) then return

    data = Syphon.serialize(view)
    model.save(data, {
      success: () ->
        AppChan.request("patient:outpatient")
      error: (model, jqXHR) ->
        if jqXHR.status != 404
          view.showErrors($.parseJSON(jqXHR.responseText).errors)
    })

export default Controller
