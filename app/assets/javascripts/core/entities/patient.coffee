import Routes from 'helpers/routes'
import { t } from 'helpers/i18n'
import Entity from './entity'

Patient = Entity.extend({
  urlRoot: -> Routes.patient_index_path()

  validation:
    name:
      required: true
      msg: -> t('general.messages.required_field')
})

export default new Patient
