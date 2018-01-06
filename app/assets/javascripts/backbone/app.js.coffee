import CalendarRouter from './apps/calendar/calendar_app'
import PatientRouter from './apps/patient/patient_app'
import loadInitializer from './config/application'

App = class extends Marionette.Application
  initialize: (options) ->
    loadInitializer 'setup', channel: 'Object'

    new CalendarRouter
    new PatientRouter

    if Backbone.history
      Backbone.history.start
        pushState: true

export default App