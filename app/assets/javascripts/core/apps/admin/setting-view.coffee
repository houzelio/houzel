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
      view: 'application'

  regions:
    settingRegion: "#setting-region"
