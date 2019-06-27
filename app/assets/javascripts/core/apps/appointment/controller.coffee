import { AppChan, ObjChan } from 'channels'
import { showView } from 'helpers/layout-region'
import { Appointment } from 'entities/index'
import FormView from './form-view'

Controller =
  newAppointment: () ->
    appointment = Appointment.create()
    ObjChan.request("when:fetched", appointment, =>
      view = @_getFormView(appointment)
      showView(view)
    )

    return

  _getFormView: (model, deleteOption) ->
    view = new FormView {model: model}

    view.on('appointment:schedule', @onAppointmentSchedule)
    if deleteOption
      view.on('appointment:confirm:delete', @onAppointmentConfirmDelete)

    view

export default Controller
