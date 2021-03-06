import { profile_index_path } from 'routes'
import { t } from 'helpers/i18n'
import Entity from './entity'

Profile = Entity.extend({
  urlRoot: -> profile_index_path()

  validation:
    name:
      required: true
      msg: -> t('general.messages.required_field')

  get: (options) ->
    Entity.prototype.get.call(@, null, options)

})

export default new Profile
