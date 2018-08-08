import LayoutBehavior from '../../behaviors/layout'
template = require('./templates/list.jst.eco')

  template: template
  tagName: "div"
  className: "content-wrapper"

  navigation: "patient"

  behaviors:
    Layout:
      behaviorClass: LayoutBehavior
      view: 'application'
export default class extends Marionette.View
