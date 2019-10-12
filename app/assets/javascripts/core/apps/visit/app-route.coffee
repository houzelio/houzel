import Routes from 'helpers/routes'
import AppRouter from 'marionette.approuter'
import Controller from './controller'

export default class extends AppRouter
  controller: Controller

  appRoutes:
    "visit" : "listVisits"
    "visit/new" : "newVisit"
    "visit/:id" : "editVisit"

