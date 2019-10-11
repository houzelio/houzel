import { AppChan } from 'channels'
import Routes from 'helpers/routes'
import AppRouter from 'marionette.approuter'
import Controller from './controller'

export default class extends AppRouter
  controller: Controller

  appRoutes:
    "service" : "listServices"
    "service/new" : "newService"
    "service/:id" : "editService"

AppChan.reply("service:list", () ->
  Backbone.history.navigate Routes.service_index_path()
  Controller.listServices()
)

AppChan.reply("service:edit", (id) ->
  Backbone.history.navigate Routes.service_path(id)
  Controller.editService(id)
)
