import { t } from 'helpers/i18n'
import Routes from 'helpers/routes'
import Cleave from 'cleave.js'
import SelectCmp from 'components/select'
import PickerCmp from 'components/datepicker'
import DialogCmp from 'components/box-dialog'
import ValidationMixin from 'mixins/validation'
import LayoutBehavior from 'behaviors/layout'
import DeleteBehavior from 'behaviors/delete'
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
    Delete:
      behaviorClass: DeleteBehavior
      triggerEvent: 'patient:confirm:delete'
      message: -> t('patient.messages.remove_patient')

  bindings:
    '#name-in' : 'name'

  triggers:
    'click #save-btn': 'patient:save'

  templateContext:
    route: () ->
      Routes.patient_index_path()

  onAttach: () ->
    @_showSelects()
    @_showPickers()

  _showSelects: () ->
    @selects = {}

    @selects['#sex-sel'] = new SelectCmp({
      el: '#sex-sel',
      disable_search: true,
      allow_single_deselect: true,
      value: @model.get("sex")
    })

    @selects['#blood-sel'] = new SelectCmp({
      el: '#blood-sel',
      disable_search: true,
      allow_single_deselect: true,
      value: @model.get("blood_type")
    })

    return

  _showPickers: () ->
    @pickers = {}

    #birthday picker
    @pickers['#birth-pickr'] = new PickerCmp({
      el: '#birth-pickr',
      wrap: true
    })

    @listenTo(@pickers['#birth-pickr'], 'picker:update', ->
      @model.set('birthday', @pickers['#birth-pickr'].getValue())
    )

    return

  onBeforeDestroy: () ->
    @pickers['#birth-pickr'].destroy()
