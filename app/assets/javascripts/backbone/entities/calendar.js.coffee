import Routes from '../helpers/routes_helper'

class Calendar extends Backbone.Model
  urlRoot: -> Routes.calendar_index_path()

newCalendar = ->
  calendar = new Calendar
  calendar.url = Routes.new_calendar_path()
  calendar.fetch()
  calendar.url = Routes.calendar_index_path()
  calendar

export {
  newCalendar
}