import { patient_index_path } from 'routes'
import { t } from 'helpers/i18n'
import Entity from './entity'

Patient = Entity.extend({
  urlRoot: -> patient_index_path()

  validation:
    name:
      required: true
      msg: -> t('general.messages.required_field')
})

export default new Patient
