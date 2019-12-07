import { t } from 'helpers/i18n'
import { formatCurr } from 'helpers/numeral'
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
      triggerEvent: 'service:confirm:delete'
      message: -> t('service.messages.remove_service')

  bindings:
    '#name-in' : 'name'
    '#value-in' :
      observe: 'value'
      onGet: (val) ->
        formatCurr(val)

  triggers:
    'click #save-btn': 'service:save'

  templateContext:
    route: () ->
      Routes.service_index_path()

  onAttach: () ->
    @_initFormatters()
    @_showSelects()

  _showSelects: () ->
    @selects = {}

    @selects['#category-sel'] = new SelectCmp({
      el: '#category-sel',
      value: @model.get("category")
    })

    return

  _initFormatters: () ->
    new Cleave('.fs-input-num', {
      numeral: true,
      numeralDecimalMark: t('numeral.format.decimal_mark'),
      delimiter: t('numeral.format.delimiter')
    })

    return
