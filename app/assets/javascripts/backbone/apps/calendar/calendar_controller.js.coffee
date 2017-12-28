import * as Calendar from '../../entities/calendar'
import Layout from '../../layouts/layout'
import FormView from './calendar_form_view'
import Radio from 'backbone.radio'

channel = Radio.channel('Object')

Controller =
  newCalendar: (args) ->
    calendar = Calendar.newCalendar()

    channel.request "when:fetched", calendar, =>
      formView = new FormView {model: calendar}
      Layout.show('mainRegion', formView)

export default Controller