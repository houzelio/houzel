import Routes from 'helpers/routes'
import { t } from 'helpers/i18n'
import PageableCollection from './_base'

Model = Backbone.Model.extend({
  urlRoot: -> Routes.service_index_path()

  validation:
    name:
      required: true
      msg: -> t('general.messages.required_field')
    value:
      required: true
      msg: -> t('general.messages.required_field')
})

Collection = PageableCollection.extend({
  model: Model
  url: -> Routes.service_index_path()
})

create = (options) ->
  service = new Model(options)
  service

get = (id) ->
  service = new Model(id: id)
  service.fetch()
  service

getList = (options) ->
  services = new Collection(options)
  services.fetch()
  services

categories = () ->
    

export {
  create,
  get,
  getList
}
