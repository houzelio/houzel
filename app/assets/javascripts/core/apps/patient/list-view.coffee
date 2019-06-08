import LayoutBehavior from 'behaviors/layout'
import template from './templates/list.pug'

export default class extends Marionette.View
  template: template
  tagName: "div"
  className: "content-wrapper"

  navigation: "patient"

  behaviors:
    Layout:
      behaviorClass: LayoutBehavior
      view: 'application'
