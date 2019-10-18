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

AppChan.reply("invoice:list", () ->
  Backbone.history.navigate  Routes.invoice_index_path()
  Controller.listInvoices()
)

AppChan.reply("invoice:new", () ->
  Backbone.history.navigate  Routes.new_invoice_path()
  Controller.newInvoice()
)

AppChan.reply("invoice:edit", (id) ->
  Backbone.history.navigate  Routes.invoice_path(id)
  Controller.editInvoice(id)
)
