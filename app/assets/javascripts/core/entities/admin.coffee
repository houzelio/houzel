import Routes from 'helpers/routes'
import Entity from './entity'

Admin = Entity.extend({

  getUsersRole: (options) ->
    @collectionClass.prototype.url = Routes.users_role_path()
    users = @getList(options)

    @collectionClass.prototype.url = null
    users

})

export default new Admin
