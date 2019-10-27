import Routes from 'helpers/routes'
import pluralize from 'pluralize'
import template from './templates/side.pug'

export default class extends Marionette.View
  template: template

  tagName: 'nav'
  className: 'sidebar'

  ui:
    collapseSelector: "[data-toggle='collapse-next']"

  templateContext:
    Routes: Routes
    route: (name) ->
      if name.match(/^new_/)
        _route = "#{name}_path"
      else
        _route = "#{pluralize.singular(name)}_index_path"

      Routes[_route]()
