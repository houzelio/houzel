import Radio from 'backbone.radio'
import Layout from '../../layouts/layout-view'
import ListView from './patient-list-view'
import { Patient } from '../../entities/index'

channel = Radio.channel('Object')

Controller =

  listPatients: ->
    patients = Patient.getPatientList()

    channel.request "when:fetched", patients, =>
      listView = new ListView { collection: patients }
      Layout.show('mainRegion', listView)


export default Controller
