import { AppChan, ObjChan } from 'channels'
import { showViewIn } from 'helpers/layout-region'
import { Profile } from 'entities/index'
import Syphon from 'backbone.syphon'
import SettingLayout from './setting-view'
import FormView from './form-view'

Controller =
  editProfile: () ->
    profile = Profile.get()

    ObjChan.request("when:fetched", profile, =>
      view = new FormView { model: profile }
      @_bindSave(view, 'profile:general:save', @onProfileSave)
      showViewIn(@_getSettingLayout('general'), 'settingRegion', view)
    )

    return

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

  _save: (view, options, attrs) ->
    model = view.model
    if !model.isValid(attrs)
      model.validate(attrs)
      return

    data = Syphon.serialize(view)
    model.save(data, options)

export default Controller
