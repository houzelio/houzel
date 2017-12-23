import * as Patient from '../../entities/patient'
import Layout from '../../layouts/layout'
import ListView from './patient_list_view'
import Radio from 'backbone.radio'

channel = Radio.channel('Object')

Controller =

  listPatients: ->
    patients = Patient.getPatientList()
    
    channel.request "when:fetched", patients, =>
      listView = new ListView { collection: patients }
      Layout.show('mainRegion', listView)


export default Controller