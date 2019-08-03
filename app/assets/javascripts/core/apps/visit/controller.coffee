import { AppChan, ObjChan } from 'channels'
import { showView } from 'helpers/layout-region'
import { Visit } from 'entities/index'
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

export default Controller
