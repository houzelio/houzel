import mom from 'moment'
import Routes from 'helpers/routes'
import SelectCmp from 'components/select'
import PickerCmp from 'components/datepicker'
import MclHistoryCmp from 'components/medical-history'
import ValidationMixin from 'mixins/validation'
import LayoutBehavior from 'behaviors/layout'
import template from './templates/form.pug'
import patientRegion from './templates/regions/patient.pug'

export default class extends Marionette.View
  template: template
  tagName: "div"
  className: "content-wrapper"

  mixins: [ValidationMixin]

  behaviors:
    Layout:
      behaviorClass: LayoutBehavior
      view: 'application'

  regions:
    patientRegion : '#patient-region'
    mclHistoryRegion: '#mcl-history-region'

  bindings:
    '#patient-sel' : 'patient_id'

  events:
    'click a[data-click]' : 'onAnchorPickerClick'

  triggers:
    'click #save-btn': 'visit:save'

  templateContext:
    route: () ->
      Routes.visit_index_path()

  onAttach: () ->
    @_showSelects()
    @_showPickers()
    @_showMclHistory(@mclHistoryCollection)

  _showSelects: () ->
    select = new SelectCmp({
      el: '#patient-sel'
    })

    @listenTo(select, 'select:change', (event, value) ->
      @triggerMethod('visit:select:patient', @, value)
    )

    return

  _showPickers: () ->
    #checkin picker
    picker = new PickerCmp({
      el: '#checkin-pickr',
      enableTime: true
    })

    @listenTo(picker, 'picker:update', ->
      @model.set('start_date', picker.getValue())
    )

    #checkin picker
    picker = new PickerCmp({
      el: '#checkout-pickr',
      enableTime: true
    })

    @listenTo(picker, 'picker:update', ->
      @model.set('end_date', picker.getValue())
    )

    return

  showPatientInfo: (patientModel, mclHistoryCollection) ->
    view = new Marionette.View({
      template: patientRegion
      model: patientModel
    })

    @_showMclHistory(mclHistoryCollection)
    @showChildView('patientRegion', view)

    return


  _showMclHistory: (mclHistoryCollection) ->
    if !mclHistoryCollection then return

    mclHistoryCmp = new MclHistoryCmp({
      mclHistoryCollection: mclHistoryCollection
    })

    mclHistoryCmp.showViewIn(@, 'mclHistoryRegion')

    return

  onAnchorPickerClick: (event) ->
    $el = $(event.currentTarget).prev()
    $el.val(mom().format('L HH:mm'))
