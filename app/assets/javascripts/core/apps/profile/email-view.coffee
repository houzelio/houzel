import ValidationMixin from 'mixins/validation'
import template from './templates/email.pug'

export default class extends Marionette.View
  template: template
  tagName: "div"

  mixins: [ValidationMixin]

  bindings:
    '#email-in' : 'email'

  triggers:
    'click #save-btn': 'profile:email:save'
