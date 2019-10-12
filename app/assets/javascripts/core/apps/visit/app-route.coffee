import { AppChan } from 'channels'
import Routes from 'helpers/routes'
import AppRouter from 'marionette.approuter'
import Controller from './controller'

export default class extends AppRouter
  controller: Controller

  appRoutes:
    "visit" : "listVisits"
    "visit/new" : "newVisit"
    "visit/:id" : "editVisit"

AppChan.reply("visit:list", () ->
  Backbone.history.navigate  Routes.visit_index_path()
  Controller.listVisits()
)

AppChan.reply("visit:new", () ->
  Backbone.history.navigate Routes.new_visit_path()
  Controller.newVisit()
)

AppChan.reply("visit:edit", (id) ->
  Backbone.history.navigate Routes.visit_path(id)
  Controller.editVisit(id)
)
