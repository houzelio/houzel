import { AppChan } from 'channels'
import Routes from 'helpers/routes'
import AppRouter from 'marionette.approuter'
import Controller from './controller'

export default class extends AppRouter
  controller: Controller

  appRoutes:
    "invoice" : "listInvoices"
    "invoice/new" : "newInvoice"
    "invoice/:id" : "editInvoice"

