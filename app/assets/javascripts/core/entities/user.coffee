import { t } from 'helpers/i18n'
import DeepModel from 'backbone.deep-model'
import Entity from './entity'

Model = DeepModel.extend({
  urlRoot: "/user"

  validation:
    email :
      required: true
      msg: -> t("general.messages.required_field")
    'password_params.current_password':
      required: true
      msg: -> t("general.messages.required_field")
    'password_params.new_password':
      required: true
      msg: -> t("general.messages.required_field")
    'password_params.password_confirmation':
      required: true
      msg: -> t("general.messages.required_field")
})

User = Entity.extend({
  url: "/user"

  modelClass: Model
})

export default new User
