import Routes from '../helpers/routes'

Model = Backbone.Model.extend({
  urlRoot: -> Routes.calendar_index_path()
})

create = (options) ->
  calendar = new Model(options)
  calendar.url = Routes.new_calendar_path()
  calendar.fetch()
  calendar.url = Routes.calendar_index_path()
  calendar

export {
  create
}
