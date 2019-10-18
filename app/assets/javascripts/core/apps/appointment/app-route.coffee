import { AppChan } from 'channels'
import Routes from 'helpers/routes'
import AppRouter from 'marionette.approuter'
import Controller from './controller'

export default class extends AppRouter
  controller: Controller

  appRoutes:
    "appointment" : "listAppointments"
    "appointment/new" : "newAppointment"
    "appointment/:id" : "editAppointment"

AppChan.reply("appointment:list", () ->
  Backbone.history.navigate  Routes.appointment_index_path()
  Controller.listAppointments()
)

AppChan.reply("appointment:new", () ->
  Backbone.history.navigate Routes.new_appointment_path()
  Controller.newAppointment()
)

AppChan.reply("appointment:edit", (id) ->
  Backbone.history.navigate Routes.appointment_path(id)
  Controller.editAppointment(id)
)
