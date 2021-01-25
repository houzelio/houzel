import { AppChan } from 'channels'

import {
  profile_index_path
} from 'routes'

import AppRouter from 'marionette.approuter'
import Controller from './controller'

export default class extends AppRouter
  controller: Controller

  appRoutes:
    "user/profile" : "editProfile"
    "user/profile/password" : "changePassword"
    "user/profile/email" : "changeEmail"

AppChan.reply("profile:edit", () ->
  Backbone.history.navigate(profile_index_path())
  Controller.editProfile()
)
