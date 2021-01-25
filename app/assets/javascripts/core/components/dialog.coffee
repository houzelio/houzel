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

  show: (dialogType, message, options) ->
    if !_.contains(dialogs, dialogType)
      throw new Error("A valid dialog is required.")

    callback = (result) =>
      @triggerMethod("dialog:action:result", result)

    dialogOptions = _.extend({},
      _.defaults(_.result(@, 'dialogOptions'), options),
      {
        message: message,
        callback: callback
      }
    )

    dialog = @_proxyDialogFn(dialogType)
    dialog(dialogOptions)

  _proxyDialogFn: (dialogType) ->
    bsDialog = bootbox

    (options) =>
      bsDialog[dialogType].call(bsDialog, options).
        on('shown.bs.modal', =>
          @triggerMethod("dialog:shown:modal")
        )
})
