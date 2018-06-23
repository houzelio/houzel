import LayoutBehavior from '../../behaviors/layout'
template = require('./templates/list.jst.eco')

export default class extends Marionette.ItemView
  template: template
  tagName: "div"
  className: "content-wrapper"

  navigation: "patient"

  behaviors:
    Layout:
      behaviorClass: LayoutBehavior
      view: 'application'
