import CalendarRouter from './calendar/app-route'
import PatientRouter from './patient/app-route'

export initApps = ->
  new CalendarRouter
  new PatientRouter
