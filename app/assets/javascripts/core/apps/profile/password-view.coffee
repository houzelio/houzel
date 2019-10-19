import ValidationMixin from 'mixins/validation'
import template from './templates/password.pug'

export default class extends Marionette.View
  template: template
  tagName: "div"

  mixins: [ValidationMixin]

  bindings:
    '#curr-password-in' : 'password_params.current_password'
    '#new-password-in' : 'password_params.new_password'
    "#password-confr-in" : 'password_params.password_confirmation'

  triggers:
    'click #save-btn': 'profile:password:save'
