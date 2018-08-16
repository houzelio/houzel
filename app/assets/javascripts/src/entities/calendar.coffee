import Routes from '../helpers/routes'

class Model extends Backbone.Model
  urlRoot: -> Routes.calendar_index_path()

create = (options) ->
  calendar = new Model(options)
  calendar.url = Routes.new_calendar_path()
  calendar.fetch()
  calendar.url = Routes.calendar_index_path()
  calendar

export {
  create
}
