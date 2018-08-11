import Radio from 'backbone.radio'
import AppRouter from 'marionette.approuter'
import Controller from './controller'

channel = Radio.channel('App')

channel.on "patient:list", (patient) ->
  Backbone.history.navigate  "/patient"
  Controller.listPatients()

export default class extends AppRouter
  appRoutes:
    "patient" : "listPatients"

  controller:
    listPatients: ->
      Controller.listPatients()
