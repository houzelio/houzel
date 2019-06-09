import { AppChan, ObjChan } from 'channels'
import { showView } from 'helpers/layout-region'
import { Patient, MclHistory } from 'entities/index'
import Syphon from 'backbone.syphon'
import ListView from './list-view'
import FormView from './form-view'
import ShowView from './show-view'

Controller =
  listPatients: () ->
    patients = Patient.getList()

    ObjChan.request("when:fetched", patients, =>
      view = new ListView { collection: patients }
      showView(view)
    )

    return

  newPatient: () ->
    patient = Patient.create()

    ObjChan.request("when:fetched", patient, =>
      view = @_getFormView(patient)
      showView(view)
    )

    return

  editPatient: (id) ->
    patient = Patient.get(id)

    ObjChan.request("when:fetched", patient, =>
      view = @_getFormView(patient, true)
      showView(view)
    )

    return

  _getFormView: (model, deleteOption) ->
    view = new FormView {model: model}

    view.on('patient:save', @onPatientSave)
    if deleteOption
      view.on('patient:confirm:delete', @onPatientConfirmDelete)

    view

  onPatientSave: (view) ->
    model = view.model
    if !model.isValid(true) then return

    data = Syphon.serialize(view)
    model.save(data, {
      success: () ->
        AppChan.request("patient:list")
      error: (model, jqXHR) ->
        if jqXHR.status != 404
          view.showErrors($.parseJSON(jqXHR.responseText).errors)
          return

        AppChan.request("patient:list")
    })

  onPatientConfirmDelete: (view) ->
    model = view.model
    model.destroy()

    AppChan.request("patient:list")

export default Controller
