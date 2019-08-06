import VisitRouter from './visit/app-route'
import AppointmentRouter from './appointment/app-route'
import PatientRouter from './patient/app-route'

export initApps = ->
  new VisitRouter
  new AppointmentRouter
  new PatientRouter
