import NotifierCmp from 'components/toast-notifier'

notifier = new NotifierCmp()

showNotification = ({text, type} = {}, position) ->
  if !position then position = 'topCenter'

  backgroundColor = switch type
    when 'info'    then '#d9edf7'
    when 'success' then '#dff0d8'
    when 'warning' then '#fcf8e3'
    when 'error'   then '#f2dede'

  notifier = new NotifierCmp(position: position)
  notifier.show(type, text, backgroundColor: backgroundColor)

  return

export {
  showNotification
}
