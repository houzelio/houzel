import Routes from 'helpers/routes'
import { t } from 'helpers/i18n'
import PageableCollection from './_base'

Model = Backbone.Model.extend({
  urlRoot: -> Routes.visit_index_path()

  validation:
    patient_id:
      required: true
      msg: -> t('general.messages.required_field')
})

Collection = PageableCollection.extend({
  model: Model
  url: -> Routes.visit_index_path()
})

create = (options) ->
  visit = new Model(options)
  visit.url = Routes.new_visit_path()
  visit.fetch()
  visit.url = Routes.visit_index_path()
  visit

get = (id, options) ->
  options = _.extend({}, options, id: id)
  visit = new Model(options)
  visit.fetch()
  visit

export {
  create,
  get
}
