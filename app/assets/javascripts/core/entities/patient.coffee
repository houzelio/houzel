import Routes from 'helpers/routes'
import { t } from 'helpers/i18n'
import PageableCollection from './_base'

Model = Backbone.Model.extend({
  urlRoot: -> Routes.patient_index_path()

  validation:
    name:
      required: true
      msg: -> t('general.messages.required_field')
})

Collection = PageableCollection.extend({
  model: Model
  url: -> Routes.patient_index_path()
})

create = (options) ->
   patient = new Model(options)
   patient

get = (id, fetchOptions) ->
  patient = new Model(id: id)
  patient.fetch(data: fetchOptions)
  patient

getList = (options) ->
  patients = new Collection(options)
  patients.fetch()
  patients

export {
  create,
  get,
  getList
}
