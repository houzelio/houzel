import Component from 'javascripts/api/component'
import "chosen-js"

Dom = Marionette.DomApi

SelectOptions = [
  'disable_search_threshold',
  'no_results_text',
  'max_selected_options',
  'allow_single_deselect',
  'width'
]

export default Component.extend({
  viewClass: false

  initialize: (options) ->
    @mergeIntoOption('selectOptions', options, SelectOptions)
    @_setElement()

    return

  show: () ->
    $el = @$el

    selectOptions = _.result(@, 'selectOptions', {})
    $el.chosen(selectOptions)

    $el.chosen().on('change', (evt, options) =>
      @triggerMethod('select:change', options)
    )

    @updateSelect()

    return

  _setElement: () ->
    el = @getOption('el')
    if !el then throw new Error('An element must be provide for a select.')

    @el = if el instanceof $ then el[0] else el
    @$el = Dom.getEl(@el)

    return

  updateSelect: () ->
    @$el.trigger('chosen:updated')

    return
})
