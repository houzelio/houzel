import { visit_index_path } from 'routes'
import { hzSignInAltSolid, hzSignOutAltSolid } from 'houzel-icons/svg-icons'
import mom from 'moment'
import SelectCmp from 'components/select'
import PickerCmp from 'components/datepicker'
import MclHistoryCmp from 'components/medical-history'
import ValidationMixin from 'mixins/validation'
import LayoutBehavior from 'behaviors/layout'
import DeleteBehavior from 'behaviors/delete'
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
    Delete:
      behaviorClass: DeleteBehavior
      triggerEvent: 'visit:confirm:delete'
      message: -> t('visit.messages.remove_visit')

  regions:
    patientRegion : '#patient-region'
    mclHistoryRegion: '#mcl-history-region'

  bindings:
    '#patient-sel' : 'patient_id'

  events:
    'click a[data-click]' : 'onAnchorPickerClick'

  triggers:
    'click #save-btn': 'visit:save'

  templateContext: =>
    icons:
      checkin: hzSignInAltSolid
      checkout: hzSignOutAltSolid
    route: () =>
      referrer = @getOption('referrer')
      if referrer then referrer else visit_index_path()

  onAttach: () ->
    @_showSelects()
    @_showPickers()
    @_showMclHistory(@getOption('mclHistoryCollection'))

  _showSelects: () ->
    @selects = {}

    @selects['#patient-sel'] = new SelectCmp({
      el: '#patient-sel'
    })

    @listenTo(@selects['#patient-sel'], 'select:change', (event, value) ->
      @triggerMethod('visit:select:patient', @, value)
    )

    return

  _showPickers: () ->
    @pickers = {}

    #checkin picker
    @pickers['#checkin-pickr'] = new PickerCmp({
      el: '#checkin-pickr'
      enableTime: true
      value: @model.get('start_date') || mom().format('L HH:mm')
    })

    @listenTo(@pickers['#checkin-pickr'], 'picker:update', ->
      @model.set('start_date', @pickers['#checkin-pickr'].getValue())
    )

    #checkin picker
    @pickers['#checkout-pickr'] = new PickerCmp({
      el: '#checkout-pickr'
      enableTime: true
    })

    @listenTo(@pickers['#checkout-pickr'], 'picker:update', ->
      @model.set('end_date', @pickers['#checkout-pickr'].getValue())
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
    id = Dom.getEl(event.currentTarget).prev().attr('id')
    @pickers["##{id}"].setValue(mom().format('L HH:mm'))

  onBeforeDestroy: () ->
    _.each(@pickers, (picker) ->
      picker.destroy()
    )
