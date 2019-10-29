import Component from 'javascripts/api/component'
import "chosen-js"

SelectOptions = [
  'disable_search',
  'disable_search_threshold',
  'no_results_text',
  'max_selected_options',
  'allow_single_deselect',
  'width'
]

export default Component.extend({
  viewClass: false

  selectOptions:
    width: '100%'

  initialize: (options) ->
    @mergeIntoOption('selectOptions', options, SelectOptions)

    el = @getOption('el')
    @el = if el instanceof $ then el[0] else el

    @_initSelect()

    return

  _initSelect: () ->
    $el = @_getEl(@el)

    selectOptions = _.result(@, 'selectOptions', {})
    $el.chosen(selectOptions).on('change', (event, options) =>
      @triggerMethod('select:change', event, @getValue(), options)
    )

    @setValue(@getOption('value'))
    @updateSelect()

    return

  setValue: (value) ->
    @$el.val(value)
    @updateSelect()

    return

  getValue: () ->
    @$el.val()

  updateSelect: () ->
    @$el.trigger('chosen:updated')

    return

  _getEl: (el) ->
    if !el then throw new Error('An element must be provide for a select.')
    @$el = Dom.getEl(@el)

})
