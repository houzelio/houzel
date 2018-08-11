import Radio from 'backbone.radio'
import LayoutMgr from 'layouts/layout-manager'
import FormView from './form-view'
import { Calendar }  from '../../entities/index'

channel = Radio.channel('Object')

Controller =
  newCalendar: (args) ->
    calendar = Calendar.newCalendar()

    channel.request "when:fetched", calendar, =>
      formView = new FormView {model: calendar}
      LayoutMgr.show('mainRegion', formView)

export default Controller
