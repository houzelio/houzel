import Component from 'javascripts/api/component'
import bootbox from 'bootbox'

DialogOptions = [
  'size',
  'scrollable',
  'onEscape',
  'backdrop',
  'closeButton',
  'animate',
  'className',
  'buttons',
  'centerVertical',
  'swapButtonOrder',
  'title',
  'backdrop'
]

dialogs = ['alert', 'confirm', 'prompt', 'dialog']

export default Component.extend({
  viewClass: false

  initialize: (options) ->
    @mergeIntoOption('dialogOptions', options, DialogOptions)

    return

  show: (dialogName, message, options) ->
    if !_.contains(dialogs, dialogName)
      throw new Error("A valid dialog is required.")

    callback = (result) =>
      @triggerMethod("dialog:action:result", result)

    dialogOptions = _.defaults(_.result(@, 'dialogOptions'), options)
    dialogOptions = _.extend({},
      dialogOptions, {
        message: message,
        callback: callback
      }
    )

    dialog = @_proxyDialogFn(dialogName)
    dialog(dialogOptions)

  _proxyDialogFn: (dialogName) ->
    bsDialog = bootbox

    (options) =>
      bsDialog[dialogName].call(bsDialog, options).
        on('shown.bs.modal', =>
          @triggerMethod("dialog:shown:modal")
        )
})
