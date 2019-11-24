import Component from 'javascripts/api/component'
import toast from 'izitoast'

NotifierOptions = [
  'class',
  'title',
  'titleColor',
  'titleSize',
  'titleLineHeight',
  'messageColor',
  'messageSize',
  'messageLineHeight',
  'backgroundColor',
  'theme',
  'color',
  'icon',
  'iconText',
  'iconColor',
  'iconUrl',
  'close',
  'closeOnEscape',
  'closeOnClick'
  'position',
  'zindex',
  'target',
  'targetFirst',
  'timeout',
  'progressBarColor',
  'transitionIn'
]

notifiers = ['info', 'show', 'success', 'warning', 'error']

export default Component.extend({
  viewClass: false

  initialize: (options) ->
    @mergeIntoOption('notifierOptions', options, NotifierOptions)

    return

  show: (notifierType, message, options) ->
    if !_.contains(notifiers, notifierType)
      throw new Error("A valid notifier is required.")

    events = _.result(@, '_notifierEvents')
    notifierOptions = _.extend(
        _.defaults(_.result(@, 'notifierOptions'), options),
        message: message,
        events
    )

    notifier = @_proxyNotifierFn(notifierType)
    notifier(notifierOptions)

  _proxyNotifierFn: (notifierType) ->
    toastNotifier = toast

    (options) =>
      toastNotifier[notifierType].call(toastNotifier, options)

  _notifierEvents: () ->
    triggerMethod = _.bind(@triggerMethod, @)

    onOpening: () ->
      triggerMethod('notifier:opening', arguments)
    onOpened: () ->
      triggerMethod('notifier:opened', arguments)
    onClosing: () ->
      triggerMethod('notifier:closing', arguments)
    onClosed: () ->
      triggerMethod('notifier:closed', arguments)

  onNotifierClosed: () ->
    toast.destroy()

})
