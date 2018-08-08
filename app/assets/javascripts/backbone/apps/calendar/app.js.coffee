import Radio from 'backbone.radio'
import AppRouter from 'marionette.approuter'
import Routes from '../../helpers/routes'
import Controller from './controller'

channel = Radio.channel('App')

channel.on "calendar:new", (calendar) ->
  Backbone.history.navigate Routes.new_calendar_path()
  Controller.newCalendar()

export default class extends AppRouter
  appRoutes:
    "calendar/new" : "newCalendar"

  controller:
    newCalendar: ->
      Controller.newCalendar()
