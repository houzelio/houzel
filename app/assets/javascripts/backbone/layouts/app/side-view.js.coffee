import template from './templates/side.pug'

export default class extends Marionette.View
  template: template

  tagName: 'nav'
  className: 'sidebar'

  ui:
    collapseSelector: "[data-toggle='collapse-next']"
