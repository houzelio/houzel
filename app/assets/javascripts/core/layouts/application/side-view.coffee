import Routes from 'helpers/routes'
import pluralize from 'pluralize'
import template from './templates/side.pug'

export default class extends Marionette.View
  template: template

  tagName: 'nav'
  className: 'sidebar'

  events:
    'click li' : 'onListItemClick'

  templateContext:
    Routes: Routes
    route: (name) ->
      if name.match(/^new_/)
        _route = "#{name}_path"
      else
        _route = "#{pluralize.singular(name)}_index_path"

      Routes[_route]()

  onListItemClick: (event) ->
    event.preventDefault()
    $el = Dom.getEl(event.currentTarget)

    targetItem = $el.data('target-item')
    if _.isUndefined(targetItem) then return

    $currentEl = Dom.getEl('.group-active')
    if !_.isEqual($el.get(0), $currentEl.get(0))
      $currentEl.next().collapse('hide')

      $currentEl.removeClass('group-active')
      $el.addClass('group-active')

    Dom.getEl("##{targetItem}").children('a').click()
