import CalendarApp from './calendar/app.js.coffee'
import PatientApp from './patient/app.js.coffee'

export initApps = ->
  new CalendarApp
  new PatientApp
