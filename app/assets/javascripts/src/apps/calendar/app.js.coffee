import { AppChan } from 'channels'
import AppRouter from 'marionette.approuter'
import Routes from '../../helpers/routes'
import Controller from './controller'

export default class extends AppRouter
  appRoutes:
    "calendar/new" : "newCalendar"

  controller:
    newCalendar: ->
      Controller.newCalendar()

AppChan.on "calendar:new", (calendar) ->
  Backbone.history.navigate Routes.new_calendar_path()
  Controller.newCalendar()
