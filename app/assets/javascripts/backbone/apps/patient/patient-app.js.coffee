import Radio from 'backbone.radio'
import Controller from './patient-controller'

channel = Radio.channel('App')

channel.on "patient:list", (patient) ->
  Backbone.history.navigate  "/patient"
  Controller.listPatients()

export default class extends Marionette.AppRouter
  appRoutes:
    "patient" : "listPatients"

  controller:
    listPatients: ->
      Controller.listPatients()
