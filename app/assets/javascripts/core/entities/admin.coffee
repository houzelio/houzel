import Routes from 'helpers/routes'
import PageableCollection from './_base'

Model = Backbone.Model.extend()

Collection = PageableCollection.extend({
  model: Model
})

getUsersRole = (options) ->
  users = new Collection(options)
  users.url = Routes.users_role_path()
  users.fetch()
  users

export {
  getUsersRole
}
