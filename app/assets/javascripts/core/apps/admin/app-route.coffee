import { AppChan } from 'channels'
import AppRouter from 'marionette.approuter'
import Controller from './controller'

export default class extends AppRouter
  controller: Controller

  appRoutes:
    "admin/users" : "listUsers"
