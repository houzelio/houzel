import Routes from '../helpers/routes'
import { t } from 'helpers/i18n'

Model = Backbone.Model.extend({
  urlRoot: -> Routes.appointment_index_path()

  validation:
    patient_id:
      required: true
    specialist_id:
      required: true
    date:
      required: true
    start_time:
      required: true
    end_time:
      required: true
})

create = (options) ->
  appointment = new Model(options)
  appointment.url = Routes.new_appointment_path()
  appointment.fetch()
  appointment.url = Routes.appointment_index_path()
  appointment

get = (id) ->
  appointment = new Model(id: id)
  appointment.fetch()
  appointment

export {
  create,
  get
}
