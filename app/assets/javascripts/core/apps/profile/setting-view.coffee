import Routes from 'helpers/routes'
import LayoutBehavior from 'behaviors/layout'
import template from './templates/setting.pug'

export default class extends Marionette.View
  template: template
  tagName: "div"
  className: "content-wrapper"

  behaviors:
    Layout:
      behaviorClass: LayoutBehavior
      view: 'user'

  regions:
    settingRegion: "#setting-region"

  templateContext: =>
    setting: () =>
      @getOption('setting')
    route: (setting) ->
      profilePath = Routes.profile_index_path()
      routes = {
        'general' : profilePath
        'password' : "#{profilePath}/password"
        'email' : "#{profilePath}/email"
      }

      routes[setting]
