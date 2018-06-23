import LayoutBehavior from '../../behaviors/layout'
template = require('./templates/form.jst.eco')

export default class extends Marionette.LayoutView
  template: template
  tagName: "div"
  className: "content-wrapper"

  behaviors:
    Layout:
      behaviorClass: LayoutBehavior
      view: 'application'
