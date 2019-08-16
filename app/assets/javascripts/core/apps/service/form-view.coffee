import { t } from 'helpers/i18n'
import { formatCurr } from 'helpers/numeral'
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

  navigation: "service"

  mixins: [ValidationMixin]

  behaviors:
    Layout:
      behaviorClass: LayoutBehavior
      view: 'application'

  bindings:
    '#name-in' : 'name'
    '#value-in' :
      observe: 'value'
      onGet: (val) ->
        formatCurr(val)

  triggers:
    'click #save-btn': 'service:save'
    'click #delete-btn' : 'service:delete'

  templateContext:
    route: () ->
      Routes.service_index_path()

  onAttach: () ->
    @_initFormatters()
    @_showSelects()

  _showSelects: () ->
    new SelectCmp({
      el: '#category-sel',
      value: @model.get("category")
    })

    return

  _initFormatters: () ->
    new Cleave('.fs-input-num', {
      numeral: true,
      numeralDecimalMark: t('numeral.formats.decimal_mark'),
      delimiter: t('numeral.formats.delimiter')
    })

    return

  onServiceDelete: () ->
    dialog = new DialogCmp(title: t('service.labels.service_delete'))
    @listenTo(dialog, 'dialog:action:result', () =>
      @triggerMethod('service:confirm:delete', @)
    )

    dialog.confirm(t('service.messages.remove_service'))
