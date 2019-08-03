import { AppChan, ObjChan } from 'channels'
import { showView } from 'helpers/layout-region'
import { Visit } from 'entities/index'
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

  _getFormView: (model, deleteOption) ->
    view = new FormView {model: model}

    view.on('visit:save', @onVisitSave)
    if deleteOption
      view.on('visit:confirm:delete', @onVisitConfirmDelete)

    view

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
