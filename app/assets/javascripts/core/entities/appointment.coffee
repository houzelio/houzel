import { new_appointment_path, appointment_index_path } from 'routes'
import { t } from 'helpers/i18n'
import Entity from './entity'

Appointment = Entity.extend({
  urlRoot: -> appointment_index_path()

  validation:
    patient_id:
      required: true
      msg: -> t('general.messages.select_item', item: t('patient.title'))
    examiner_id:
      required: true
      msg: -> t('general.messages.select_item', item: t('appointment.labels.examiner'))
    date:
      required: true
      msg: -> t('general.messages.required_field')
    start_time:
      required: true
      msg: -> t('general.messages.required_field')
    end_time:
      required: true
      msg: -> t('general.messages.required_field')

  create: (attrs, options) ->
    options = _.extend({}, options, {
      urlRoot: new_appointment_path(), fetch: true
    })

    Entity.prototype.create.call(@, attrs, options)

})

export default new Appointment
