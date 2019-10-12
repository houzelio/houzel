import Routes from 'helpers/routes'
import SelectCmp from 'components/select'
import PickerCmp from 'components/datepicker'
import ValidationMixin from 'mixins/validation'
import LayoutBehavior from 'behaviors/layout'
import template from './templates/form.pug'

export default class extends Marionette.View
  template: template
  tagName: "div"
  className: "content-wrapper"

  mixins: [ValidationMixin]

  behaviors:
    Layout:
      behaviorClass: LayoutBehavior
      view: 'application'

  bindings:
    '#patient-sel' : 'patient_id'
    '#specialist-sel' : 'specialist_id'
    '#date-in' : 'date'
    '#start-in' : 'start_time'
    '#end-in' : 'end_time'

  triggers:
    'click #schedule-btn': 'appointment:schedule'

  templateContext:
    route: () ->
      Routes.appointment_index_path()

  onAttach: () ->
    @_showSelects()
    @_showPickers()

  _showSelects: () ->
    new SelectCmp({
      el: '#patient-sel',
      value: @model.get("patient_id")
    })

    new SelectCmp({
      el: '#specialist-sel'
      value: @model.get("examiner_id")
    })

    return

  _showPickers: () ->
    #date picker
    picker = new PickerCmp({
      el: '#date-pickr',
      minDate: 'today',
      wrap: true
    })

    @listenTo(picker, 'picker:update', ->
      @model.set('date', $('#date-in').val())
    )

    #start-time picker
    picker = new PickerCmp({
      el: '#start-pickr',
      enableTime: true,
      noCalendar: true,
      wrap: true
    })

    @listenTo(picker, 'picker:update', ->
      @model.set('start_time', $('#start-in').val())
    )

    #end-time picker
    picker = new PickerCmp({
      el: '#end-pickr',
      enableTime: true,
      noCalendar: true,
      wrap: true
    })

    @listenTo(picker, 'picker:update', ->
      @model.set('end_time', $('#end-in').val())
    )

    return
