import { AppChan, ObjChan } from 'channels'
import { showView } from 'helpers/layout-manager'
import { Visit, Patient, MclHistory } from 'entities/index'
import Syphon from 'backbone.syphon'
import FormView from './form-view'
import ListView from './list-view'

Controller =
  listVisits: () ->
    visits = Visit.getList()

    ObjChan.request("when:fetched", visits, =>
      view = new ListView { collection: visits }
      showView(view)
    )

    return

  newVisit: () ->
    visit = Visit.create()

    ObjChan.request("when:fetched", visit, =>
      view = @_getFormView(visit)
      view.on('visit:select:patient', @onVisitSelectPatient)
      showView(view)
    )

    return

  editVisit: (id, referrer) ->
    visit = Visit.get(id)
    mcl_histories = MclHistory.getList({ fetchOptions: visit_id: id })

    ObjChan.request("when:fetched", [visit, mcl_histories], =>
      options = { referrer: referrer, mclHistoryCollection: mcl_histories }
      view = @_getFormView(visit, true, options)
      showView(view)
    )

    return

  _getFormView: (model, deleteOption, options) ->
    view = new FormView(_.extend({ model: model }, options))

    view.on('visit:save', @onVisitSave)
    if deleteOption
      view.on('visit:confirm:delete', @onVisitConfirmDelete)

    view

  onVisitSelectPatient: (view, id) ->
    patient = Patient.get(id)
    mcl_histories = MclHistory.getList({ patient_id: id })

    ObjChan.request("when:fetched", [patient, mcl_histories], =>
      patient = Patient.create({patient: _.clone(patient.attributes)})
      view.showPatientInfo(patient, mcl_histories)
    )

  onVisitSave: (view) ->
    model = view.model
    if !model.isValid(true) then return

    data = Syphon.serialize(view)
    model.save(data, {
      success: () ->
        AppChan.request("visit:list")
      error: (model, jqXHR) ->
        view.showRespErrors(jqXHR)
    })

  onVisitConfirmDelete: (view) ->
    model = view.model
    model.destroy({
      success: () ->
        AppChan.request("visit:list")
    })

export default Controller
