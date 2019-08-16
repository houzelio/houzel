import { AppChan } from 'channels'
import { showView } from 'helpers/layout-region'
import { formatCurr } from 'helpers/numeral'
import Syphon from 'backbone.syphon'

Controller =
  onServiceSave: (view) ->
    model = view.model
    if !model.isValid(true) then return

    data = Syphon.serialize(view)
    data.value = formatCurr(data.value)
    model.save(data, {
      success: () ->
        AppChan.request("service:list")
      error: (model, jqXHR) ->
        if jqXHR.status != 404
          view.showErrors($.parseJSON(jqXHR.responseText).errors)
          return

        AppChan.request("service:list")
    })

export default Controller
