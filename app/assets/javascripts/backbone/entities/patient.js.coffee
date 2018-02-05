import Routes from '../helpers/routes'
import PageableCollection from './_base'

class Patient extends Backbone.Model
 urlRoot: -> Routes.patient_index_path()

class PatientCollection extends PageableCollection
  model: Patient
  url: -> Routes.patient_index_path()


getPatientList = ->
  patients = new PatientCollection
  patients.fetch()
  patients

export {
  getPatientList
}
