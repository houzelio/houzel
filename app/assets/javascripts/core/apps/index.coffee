import VisitRouter from './visit/app-route'
import AppointmentRouter from './appointment/app-route'
import PatientRouter from './patient/app-route'
import ServiceRouter from './service/app-route'
import AdminRouter from './admin/app-route'

export initApps = ->
  new VisitRouter
  new AppointmentRouter
  new PatientRouter
  new ServiceRouter
  new AdminRouter
