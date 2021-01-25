import DialogCmp from 'components/box-dialog'

export default class extends Marionette.Behavior
  events:
    'click #delete-btn' : 'onDelete'

  onDelete: (event) ->
    event.preventDefault()

    triggerEvent = @getOption('triggerEvent') || 'view:confirm:delete'

    dialog = new DialogCmp
    @listenTo(dialog, 'dialog:action:result', (ok) =>
      if ok then @view.triggerMethod(triggerEvent, @view)
    )

    dialog.confirm(_.result(@options, 'message'))
