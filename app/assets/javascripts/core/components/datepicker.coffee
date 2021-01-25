import mom from 'moment'
import Component from 'javascripts/api/component'
import flatpickr from 'flatpickr'

PickerOptions = [
  'enableTime',
  'noCalendar',
  'altFormat',
  'altInput',
  'altInputClass',
  'allowInput',
  'clickOpens',
  'dateFormat',
  'defaultDate',
  'defaultHour',
  'defaultMinute',
  "disableMobile",
  'inline',
  'enable',
  'disable',
  'maxDate',
  'minDate',
  'mode',
  'static',
  'time_24hr',
  'position',
  'wrap'
]

FormatingTokens = {
  'pt-br' : 'd/m/Y'
  'en'    : 'Y/m/d'
}

dateFormat = (options) ->
  if options['noCalendar'] then return

  format = FormatingTokens[mom().locale()] || FormatingTokens['en']
  if options['enableTime']
    format = format + ' H:i'

  format

export default Component.extend({
  viewClass: false

  initialize: (options) ->
    options['dateFormat'] = _.result(options, 'dateFormat', dateFormat(options))
    @mergeIntoOption('pickerOptions', options, PickerOptions)

    el = @getOption('el')
    @el = if el instanceof $ then el[0] else el

    @_initPicker()

    return

  _initPicker: () ->
    events = _.result(@, '_pickerEvents')
    pickerOptions =  _.extend({},
      _.defaults(_.result(@, 'pickerOptions', {}), disableMobile: 'true'),
      events)

    picker = flatpickr(@el, pickerOptions)
    @currentPicker = picker

    value = @getOption('value')
    if value then @setValue(value)

    return

  _pickerEvents: () ->
    triggerMethod = _.bind(@triggerMethod, @)

    onChange: () ->
      triggerMethod('picker:change', arguments)
    onOpen: () ->
      triggerMethod('picker:open', arguments)
    onClose: () ->
      triggerMethod('picker:close', arguments)
    onValueUpdate: () ->
      triggerMethod('picker:update', arguments)

  setValue: (value) ->
    @currentPicker.setDate(value)

  getValue: () ->
    $el = Dom.getEl(@el)
    if $el.hasClass('flatpickr-wrapper')
      $el = $el.children('input')

    $el.val()

  onBeforeDestroy: () ->
    @currentPicker.destroy()

})
