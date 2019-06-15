import { t } from 'helpers/i18n'
import Routes from 'helpers/routes'
import Cleave from 'cleave.js'
import SelectCmp from 'components/select'
import PickerCmp from 'components/datepicker'
import DialogCmp from 'components/box-dialog'
import ValidationMixin from 'mixins/validation'
import LayoutBehavior from 'behaviors/layout'
import template from './templates/form.pug'

export default class extends Marionette.View
  template: template
  tagName: "div"
  className: "content-wrapper"

  navigation: "patient"

  mixins: [ValidationMixin]

  behaviors:
    Layout:
      behaviorClass: LayoutBehavior
      view: 'application'

  bindings:
    '#name-in' : 'name'

  triggers:
    'click #save-btn': 'patient:save'
    'click #delete-btn' : 'patient:delete'

  templateContext:
    route: () ->
      Routes.patient_index_path()

  onAttach: () ->
    @_showSelects()
    @_showPickers()

  _showSelects: () ->
    new SelectCmp({
      el: '#sex-sel',
      disable_search: true,
      allow_single_deselect: true,
      value: @model.get("sex")
    })

    new SelectCmp({
      el: '#blood-sel',
      disable_search: true,
      allow_single_deselect: true,
      value: @model.get("blood_type")
    })

    return

  _showPickers: () ->
    #birthday picker
    picker = new PickerCmp({
      el: '#birth-pickr',
      wrap: true
    })

    @listenTo(picker, 'picker:update', ->
      @model.set('birthday', $('#birth-in').val())
    )

    return

  onServiceDelete: () ->
    dialog = new DialogCmp(title: t('patient.labels.delete_patient'))
    @listenTo(dialog, 'dialog:action:result', () =>
      @triggerMethod('patient:confirm:delete', @)
    )

    dialog.confirm(t('patient.messages.remove_patient'))