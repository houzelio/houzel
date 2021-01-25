import { AppChan } from 'channels'

import {
  service_index_path,
  new_service_path,
  service_path
} from 'routes'

import AppRouter from 'marionette.approuter'
import Controller from './controller'

export default class extends AppRouter
  controller: Controller

  appRoutes:
    "service" : "listServices"
    "service/new" : "newService"
    "service/:id" : "editService"

AppChan.reply("service:list", () ->
  Backbone.history.navigate(service_index_path())
  Controller.listServices()
)

AppChan.reply("service:new", () ->
  Backbone.history.navigate(new_service_path())
  Controller.newPatient()
)

AppChan.reply("service:edit", (id) ->
  Backbone.history.navigate(service_path(id))
  Controller.editService(id)
)
