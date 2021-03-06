import { AppChan } from 'channels'
import { profile_index_path, users_role_path } from 'routes'
import { hzBarsSolid, hzCogSolid } from 'houzel-icons/svg-icons'
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
    icons:
      bars: hzBarsSolid
      cog: hzCogSolid
    route: (name) ->
      path = switch name
        when 'profile' then profile_index_path()
        when 'settings' then users_role_path()

      path

  onAnchorToggleState: (event) ->
    className = Dom.getEl(event.currentTarget).data('toggleState')

    if className then Dom.getEl('body').toggleClass(className)
