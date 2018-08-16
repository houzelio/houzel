import { ObjChan } from 'channels'
import LayoutMgr from 'helpers/layout-manager'
import ListView from './list-view'
import { Patient, MclHistory } from 'entities/index'

Controller =
  listPatients: ->
    patients = Patient.getList()

    ObjChan.request "when:fetched", patients, =>
      listView = new ListView { collection: patients }
      LayoutMgr.show('mainRegion', listView)


export default Controller
