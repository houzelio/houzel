import { ObjChan } from 'channels'
import LayoutMgr from 'helpers/layout-manager'
import FormView from './form-view'
import { Calendar }  from 'entities/index'

Controller =
  newCalendar: (args) ->
    calendar = Calendar.create()

    ObjChan.request "when:fetched", calendar, =>
      formView = new FormView {model: calendar}
      LayoutMgr.show('mainRegion', formView)

export default Controller
