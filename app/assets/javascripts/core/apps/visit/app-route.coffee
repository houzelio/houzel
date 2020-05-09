import { AppChan } from 'channels'

import {
  visit_index_path,
  new_visit_path,
  visit_path
} from 'routes'

import AppRouter from 'marionette.approuter'
import Controller from './controller'

export default class extends AppRouter
  controller: Controller

  appRoutes:
    "visit" : "listVisits"
    "visit/new" : "newVisit"
    "visit/:id" : "editVisit"

AppChan.reply("visit:list", () ->
  Backbone.history.navigate(visit_index_path())
  Controller.listVisits()
)

AppChan.reply("visit:new", () ->
  Backbone.history.navigate(new_visit_path())
  Controller.newVisit()
)

AppChan.reply("visit:edit", (id, referrer) ->
  Backbone.history.navigate(visit_path(id))
  Controller.editVisit(id, referrer)
)
