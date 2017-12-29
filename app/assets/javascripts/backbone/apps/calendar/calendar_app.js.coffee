import Controller from './calendar_controller'
import Routes from '../../helpers/routes_helper'
import Radio from 'backbone.radio'

channel = Radio.channel('App')

channel.on "calendar:new", (calendar) ->
  Backbone.history.navigate Routes.new_calendar_path()
  Controller.newCalendar()

export default class extends Marionette.AppRouter
  appRoutes:
    "calendar/new" : "newCalendar"

  controller:
    newCalendar: ->
      Controller.newCalendar()