import { ObjChan } from 'channels'
import LayoutMgr from 'layouts/layout-manager'
import FormView from './form-view'
import { Calendar }  from 'entities/index'

Controller =
  newCalendar: (args) ->
    calendar = Calendar.newCalendar()

    ObjChan.request "when:fetched", calendar, =>
      formView = new FormView {model: calendar}
      LayoutMgr.show('mainRegion', formView)

export default Controller
