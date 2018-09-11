import LayoutBehavior from '../../behaviors/layout'
template = require('./templates/form.pug')

export default class extends Marionette.View
  template: template
  tagName: "div"
  className: "content-wrapper"

  behaviors:
    Layout:
      behaviorClass: LayoutBehavior
      view: 'application'
