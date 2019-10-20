import { AppChan } from 'channels'
import Routes from 'helpers/routes'
import AppRouter from 'marionette.approuter'
import Controller from './controller'

export default class extends AppRouter
  controller: Controller

  appRoutes:
    "user/profile" : "editProfile"
    "user/profile/password" : "changePassword"
    "user/profile/email" : "changeEmail"
)
