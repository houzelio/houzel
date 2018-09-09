import Routes from '../helpers/routes'
import PageableCollection from './_base'

Model = Backbone.Model.extend({
 urlRoot: -> Routes.patient_index_path()
})

Collection = PageableCollection.extend({
  model: Model
  url: -> Routes.patient_index_path()
})

create = (options) ->
   patient = new Model(options)
   patient

getList = ->
  patients = new Collection
  patients.fetch()
  patients

export {
  getList
}
