import DialogCmp from 'components/dialog'

export default DialogCmp.extend({
  alert: (message, options) ->
    @_show('alert', message, options)

  confirm: (message, options) ->
    @_show('confirm', message, options)

  _show: (dialogType, message, options) ->
    template = require("./templates/box-dialog/#{dialogType}.pug")
    _message = template({ message: message })

    DialogCmp.prototype.show.call(@, dialogType, _message, options)
})
