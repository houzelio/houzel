import Routes from 'helpers/routes'
import { t } from 'helpers/i18n'
import PageableCollection from './_base'

Model = Backbone.Model.extend({
  urlRoot: -> "/user"
})

Collection = PageableCollection.extend({
  model: Model
  url: -> "/user"
})

create = (options) ->
  user = new Model(options)
  user

export {
  create
}
