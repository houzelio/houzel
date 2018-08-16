import Routes from '../helpers/routes'
import PageableCollection from './_base'

class Model extends Backbone.Model
 urlRoot: -> Routes.patient_index_path()

class Collection extends PageableCollection
  model: Model
  url: -> Routes.patient_index_path()


getList = ->
  patients = new Collection
  patients.fetch()
  patients

export {
  getList
}
