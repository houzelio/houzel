import { AppChan, ObjChan } from 'channels'
import { showViewIn } from 'helpers/layout-region'
import { Profile, User } from 'entities/index'
import Syphon from 'backbone.syphon'
import SettingLayout from './setting-view'
import FormView from './form-view'
import PasswordView from './password-view'
import EmailView from './email-view'

Controller =
  editProfile: () ->
    profile = Profile.get()

    ObjChan.request("when:fetched", profile, =>
      view = new FormView { model: profile }
      @_bindSave(view, 'profile:general:save', @onProfileSave)
      showViewIn(@_getSettingLayout('general'), view, 'settingRegion')
    )

    return

  changePassword: () ->
    user = User.create(id: "_")

    ObjChan.request("when:fetched", user, =>
      view = new PasswordView { model: user }
      @_bindSave(view, 'profile:password:save', @onPasswordSave)
      showViewIn(@_getSettingLayout('password'), view, 'settingRegion')
    )

  changeEmail: () ->
    user = User.create(id: "_")

    ObjChan.request("when:fetched", user, =>
      view = new EmailView { model: user }
      @_bindSave(view, 'profile:email:save', @onEmailSave)
      showViewIn(@_getSettingLayout('email'), view, 'settingRegion')
    )

  _getSettingLayout: (setting) ->
    new SettingLayout { setting: setting }

  _bindSave: (view, eventName, callback) ->
    view.on(eventName, callback, @)

  onProfileSave: (view) ->
    @_save(view, {
      success: (..., response) ->
        jqXHR = response.xhr
        path = _.property(['responseJSON', 'path'])(jqXHR)

        if path then view.showInfo( -> location.assign(path) )
      error: (model, jqXHR) ->
        view.showRespErrors(jqXHR)
    }, 'name')

  onPasswordSave: (view) ->
    parent = "password_params"
    attrs = ["#{parent}.current_password", "#{parent}.new_password", "#{parent}.password_confirmation"]

    @_save(view, {
      success: () ->
        location.assign('/signin')
    }, attrs)

  onEmailSave: (view) ->
    @_save(view,  {
      success: () ->
        AppChan.request("profile:edit")
      error: (model, jqXHR) ->
        view.showRespErrors(jqXHR)
    }, 'email')

  _save: (view, options, attrs) ->
    model = view.model
    if !model.isValid(attrs)
      model.validate(attrs)
      return

    data = Syphon.serialize(view)
    model.save(data, options)

export default Controller
