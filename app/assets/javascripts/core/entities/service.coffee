import { service_index_path } from 'routes'
import { t } from 'helpers/i18n'
import Entity from './entity'

Service = Entity.extend({
  urlRoot: -> service_index_path()

  validation:
    name:
      required: true
      msg: -> t('general.messages.required_field')
    value:
      required: true
      msg: -> t('general.messages.required_field')
})

export default new Service
