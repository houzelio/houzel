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
    '#examiner-sel' : 'examiner_id'
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
    @selects = {}

    @selects['#patient-sel'] = new SelectCmp({
      el: '#patient-sel',
      value: @model.get("patient_id")
    })

    @selects['#examiner-sel'] = new SelectCmp({
      el: '#examiner-sel'
      value: @model.get("examiner_id")
    })

    return

  _showPickers: () ->
    @pickers = {}

    #date picker
    @pickers['#date-pickr'] = new PickerCmp({
      el: '#date-pickr',
      minDate: 'today',
      wrap: true
    })

    @listenTo(@pickers['#date-pickr'], 'picker:update', ->
      @model.set('date', Dom.getEl('#date-in').val())
    )

    #start-time picker
    @pickers['#start-pickr'] = new PickerCmp({
      el: '#start-pickr',
      enableTime: true,
      noCalendar: true,
      wrap: true
    })

    @listenTo(@pickers['#start-pickr'], 'picker:update', ->
      @model.set('start_time', Dom.getEl('#start-in').val())
    )

    #end-time picker
    @pickers['#end-pickr'] = new PickerCmp({
      el: '#end-pickr',
      enableTime: true,
      noCalendar: true,
      wrap: true
    })

    @listenTo(@pickers['#end-pickr'], 'picker:update', ->
      @model.set('end_time', Dom.getEl('#end-in').val())
    )

    return

  onBeforeDestroy: () ->
    _.each(@pickers, (picker) ->
      picker.destroy()
    )
