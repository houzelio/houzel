import CalendarApp from './calendar/calendar-app.js.coffee'
import PatientApp from './patient/patient-app.js.coffee'

export initApps = ->
  new CalendarApp
  new PatientApp
