import { AppChan, ObjChan } from 'channels'
import { showView } from 'helpers/layout-region'
import { formatCurr } from 'helpers/numeral'
import { Service }  from 'entities/index'
import Syphon from 'backbone.syphon'
import FormView from './form-view'
import ListView from './list-view'

Controller =
  listServices: () ->
    services = Service.getList()
    ObjChan.request("when:fetched", services, =>
      view = new ListView { collection: services }
      showView(view)
    )

    return

  newService: () ->
    service = Service.create()
    ObjChan.request("when:fetched", service, =>
      view = @_getFormView(service)
      showView(view)
    )

    return

  editService: (id) ->
    service = Service.get(id)
    ObjChan.request("when:fetched", service, =>
      view = @_getFormView(service, true)
      showView(view)
    )

    return

  _getFormView: (model, deleteOption) ->
    view = new FormView {model: model}

    view.on('service:save', @onServiceSave)
    if deleteOption
      view.on('service:confirm:delete', @onServiceConfirmDelete)

    view

  onServiceSave: (view) ->
    model = view.model
    if !model.isValid(true) then return

    data = Syphon.serialize(view)
    data.value = formatCurr(data.value)
    model.save(data, {
      success: () ->
        AppChan.request("service:list")
      error: (model, jqXHR) ->
        view.showRespErrors(jqXHR)
    })

  onServiceConfirmDelete: (view) ->
    model = view.model
    model.destroy({
      success: () ->
        AppChan.request("service:list")
    })

export default Controller
