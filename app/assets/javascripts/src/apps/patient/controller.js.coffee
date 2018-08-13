import { ObjChan } from 'channels'
import LayoutMgr from 'layouts/layout-manager'
import ListView from './list-view'
import { Patient } from '../../entities/index'

Controller =
  listPatients: ->
    patients = Patient.getPatientList()

    ObjChan.request "when:fetched", patients, =>
      listView = new ListView { collection: patients }
      LayoutMgr.show('mainRegion', listView)


export default Controller
