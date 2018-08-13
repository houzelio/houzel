import { AppChan } from 'channels'
import AppRouter from 'marionette.approuter'
import Controller from './controller'

export default class extends AppRouter
  appRoutes:
    "patient" : "listPatients"

  controller:
    listPatients: ->
      Controller.listPatients()

AppChan.on "patient:list", (patient) ->
  Backbone.history.navigate  "/patient"
  Controller.listPatients()
