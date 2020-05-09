import { AppChan } from 'channels'
import { profile_index_path, users_role_path } from 'routes'
import { isBreakpoint } from 'helpers/responsive'
import logo from 'images/logo-porcelain.svg'
import template from './templates/header.pug'

export default class extends Marionette.View
  template: template

  events:
    'click a[data-toggle-state]' : 'onAnchorToggleState'
    'click #logout' : () ->
      AppChan.request("user:signout")

  templateContext: ->
    logo: logo
    isBreakpoint: isBreakpoint
    route: (name) ->
      path = switch name
        when 'profile' then profile_index_path()
        when 'settings' then users_role_path()

      path

  onAnchorToggleState: (event) ->
    className = Dom.getEl(event.currentTarget).data('toggleState')

    if className then Dom.getEl('body').toggleClass(className)
