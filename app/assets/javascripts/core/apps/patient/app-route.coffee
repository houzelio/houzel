import { AppChan } from 'channels'

import {
  patient_index_path,
  new_patient_path,
  patient_path
} from 'routes'

import AppRouter from 'marionette.approuter'
import Controller from './controller'

export default class extends AppRouter
  controller: Controller

  appRoutes:
    "patient" : "listPatients"
    "patient/new" : "newPatient"
    "patient/:id" : "showPatient"

AppChan.reply("patient:list", () ->
  Backbone.history.navigate(patient_index_path())
  Controller.listPatients()
)

AppChan.reply("patient:new", () ->
  Backbone.history.navigate(new_patient_path())
  Controller.newPatient()
)

AppChan.reply("patient:show", (id) ->
  Backbone.history.navigate(patient_path(id))
  Controller.showPatient(id)
)

AppChan.reply("patient:edit", (id) ->
  Backbone.history.navigate(patient_path(id))
  Controller.editPatient(id)
)
