import Radio from 'backbone.radio'
import Layout from '../../layouts/layout-view'
import FormView from './calendar-form-view'
import Calendar from '../../entities/index'

channel = Radio.channel('Object')

Controller =
  newCalendar: (args) ->
    calendar = Calendar.newCalendar()

    channel.request "when:fetched", calendar, =>
      formView = new FormView {model: calendar}
      Layout.show('mainRegion', formView)

export default Controller
