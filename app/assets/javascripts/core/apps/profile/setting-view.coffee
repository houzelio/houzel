import { profile_index_path } from 'routes'
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
    route: (name) ->
      _route = profile_index_path()
      if !(name == "general") then _route = "#{_route}/#{name}"
      _route
