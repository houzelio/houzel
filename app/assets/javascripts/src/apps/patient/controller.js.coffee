import Radio from 'backbone.radio'
import LayoutMgr from 'layouts/layout-manager'
import ListView from './list-view'
import { Patient } from '../../entities/index'

channel = Radio.channel('Object')

Controller =
  listPatients: ->
    patients = Patient.getPatientList()

    channel.request "when:fetched", patients, =>
      listView = new ListView { collection: patients }
      LayoutMgr.show('mainRegion', listView)


export default Controller
