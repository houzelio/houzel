import { users_role_path } from 'routes'
import Entity from './entity'

Admin = Entity.extend({

  getUsersRole: (options) ->
    @collectionClass.prototype.url = users_role_path()
    users = @getList(options)

    @collectionClass.prototype.url = null
    users

})

export default new Admin
