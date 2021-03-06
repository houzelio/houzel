import { AppChan, ObjChan } from 'channels'
import { showView } from 'helpers/layout-manager'
import { Appointment } from 'entities/index'
import Syphon from 'backbone.syphon'
import FormView from './form-view'
import ListView from './list-view'

Controller =
  listAppointments: () ->
    appointments = Appointment.getList()
    ObjChan.request("when:fetched", appointments, =>
      view = new ListView { collection: appointments }
      showView(view)
    )

    return

  newAppointment: () ->
    appointment = Appointment.create()
    ObjChan.request("when:fetched", appointment, =>
      view = @_getFormView(appointment)
      showView(view)
    )

    return

  editAppointment: (id) ->
    appointment = Appointment.get(id)
    ObjChan.request("when:fetched", appointment, =>
      view = @_getFormView(appointment, true)
      showView(view)
    )

    return

  _getFormView: (model, deleteOption) ->
    view = new FormView {model: model}

    view.on('appointment:schedule', @onAppointmentSchedule)
    if deleteOption
      view.on('appointment:confirm:delete', @onAppointmentConfirmDelete)

    view

  onAppointmentSchedule: (view) ->
    model = view.model
    if !model.isValid(true) then return

    data = Syphon.serialize(view)
    model.save(data, {
      success: () ->
        AppChan.request("appointment:list")
      error: (post, jqXHR) ->
        if jqXHR.status == 422
          errors = $.parseJSON(jqXHR.responseText).errors

          # Objects validated by the plugin 'validated_associated'
          # return an array of fully-formatted error messages.
          if _.has(errors, 'appointment')
            attrs = { start_time: 'start_date', end_time: 'end_date' }

            _.each(_.result(errors, 'appointment'), (error) ->
              _.each(attrs, (attr, key) ->
                attr = new RegExp(attr)

                if error.match(attr)
                  errors[key] = error.replace(attr, '').trimStart()
              )
            )

          view.showErrors(errors)
    })

    return

  onAppointmentConfirmDelete: (view) ->
    model = view.model
    model.destroy({
      success: () ->
        AppChan.request("appointment:list")
    })

export default Controller
