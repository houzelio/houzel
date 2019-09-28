import { ObjChan } from 'channels'
import { showViewIn } from 'helpers/layout-region'
import { Admin, User } from 'entities/index'
import SettingLayout from './setting-view'
import UserView from './user-view'

Controller =
  listUsers: () ->
    users = Admin.getUsersRole()
    ObjChan.request("when:fetched", users, =>
      view = new UserView {collection: users}
      view.on('admin:remove:user', @onAdminRemoveUser)
      showViewIn(@_getSettingLayout(), 'settingRegion', view)
    )

    return

  _getSettingLayout: () ->
    new SettingLayout

  onAdminRemoveUser: (model, collection) ->
    user = User.create(id: model.get('id'))
    user.destroy({
      success: () ->
        collection.remove(model)
    })

export default Controller
