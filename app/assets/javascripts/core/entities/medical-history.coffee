import Routes from 'helpers/routes'
import PageableCollection from './_base'

Model = Backbone.Model.extend({
  urlRoot: -> Routes.medical_history_index_path()
})

Collection = PageableCollection.extend({
  model: Model
  url: -> Routes.medical_history_index_path()
})

getList = (params, options) ->
  mcl_histories = new Collection(null, options)
  mcl_histories.fetch(data: params)
  mcl_histories

export {
  getList
}
