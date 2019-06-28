import { AppChan } from 'channels'
import Routes from 'helpers/routes'
import AppRouter from 'marionette.approuter'
import Controller from './controller'

export default class extends AppRouter
  controller: Controller

  appRoutes:
    "appointment/new" : "newAppointment"
    "appointment/:id" : "editAppointment"

AppChan.on("appointment:new", () ->
  Backbone.history.navigate Routes.new_appointment_path()
  Controller.newAppointment()
)

AppChan.on("appointment:edit", (id) ->
  Backbone.history.navigate Routes.appointment_path(id)
  Controller.editAppointment(id)
)
