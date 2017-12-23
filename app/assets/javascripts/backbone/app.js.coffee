import PatientRouter from './apps/patient/patient_app'

App = class extends Marionette.Application
  initialize: (options) ->
    new PatientRouter

    if Backbone.history
      Backbone.history.start
        pushState: true

export default App