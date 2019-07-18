import DialogCmp from 'components/modal-dialog'

export default DialogCmp.extend({

  confirm: (message, options) ->
    @_show('confirm', message, options)

  _show: (dialogType, message, options) ->
    template = require("./templates/box-dialog/#{dialogType}.pug")
    _message = template({message: message})

    DialogCmp.prototype.show.call(@, dialogType, _message, options)


})
