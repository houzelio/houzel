import Routes from 'helpers/routes'
import { isBreakpoint } from 'helpers/responsive'
import template from './templates/header.pug'

export default class extends Marionette.View
  template: template

  events:
    'click a[data-toggle-state]' : 'onAnchorToggleState'

  templateContext: ->
    isBreakpoint: isBreakpoint
    route: (name) ->
      switch name
        when 'profile' then Routes.profile_index_path()
        when 'settings' then Routes.users_role_path()

  onAnchorToggleState: (event) ->
    className = Dom.getEl(event.currentTarget).data('toggleState')

    if className then Dom.getEl('body').toggleClass(className)
