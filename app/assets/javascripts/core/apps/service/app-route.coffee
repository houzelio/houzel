import Routes from 'helpers/routes'
import AppRouter from 'marionette.approuter'
import Controller from './controller'

export default class extends AppRouter
  controller: Controller

  appRoutes:
    "service" : "listServices"
    "service/new" : "newService"
    "service/:id" : "editService"
