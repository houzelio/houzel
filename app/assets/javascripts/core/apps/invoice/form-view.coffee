import { t } from 'helpers/i18n'
import { formatCurr, add } from 'helpers/numeral'
import Routes from 'helpers/routes'
import Cleave from 'cleave.js'
import GridCmp from 'components/grid'
import SelectCmp from 'components/select'
import PickerCmp from 'components/datepicker'
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

  ui:
    total : '#total-td'

  regions:
    patientRegion : '#patient-region'

  bindings:
    '#patient-sel' : 'patient_id'

  events:
    'click #btn-service' : 'onAddService'
    'click #save-btn' : 'onSaveClick'

  templateContext: =>
    total: () =>
      formatCurr(@model.get('total'))
    route: () ->
      Routes.invoice_index_path()

  initialize: (options) ->
    @_buildGrid()

    return

  onAttach: () ->
    @_showSelects()
    @_showPickers()

    @grid.showView()

  _showSelects: () ->
    @selects = {}

    @selects['#patient-sel'] = new SelectCmp({
      el: '#patient-sel'
    })

    @listenTo(@selects['#patient-sel'], 'select:change', (event, value) ->
      @triggerMethod('invoice:select:patient', @, value)
    )

    @selects['#service-sel'] = new SelectCmp({
      el: '#service-sel'
    })

    return

  _showPickers: () ->
    @pickers = {}

    #date picker
    @pickers['#date-pickr'] = new PickerCmp({
      el: '#date-pickr'
      wrap: true
    })

    @listenTo(@pickers['#date-pickr'], 'picker:update', ->
      @model.set('date', @pickers['#date-pickr'].getValue())
    )

    return

  _initFormatter: (el) ->
    new Cleave(el, {
      numeral: true,
      numeralDecimalMark: t('numeral.format.decimal_mark'),
      delimiter: t('numeral.format.delimiter')
    })

    return

  _buildGrid: () ->
    triggerMethod = _.bind(@triggerMethod, @)

    columns = [
      name: 'name'
      label: t('invoice.labels.description')
      cell: 'string'
    ,
      name: 'service_value'
      label: t('invoice.labels.base_price')
      cell: 'string'
      formatter: (rawData, model) ->
        formatCurr(rawData)
    ,
      name: 'value'
      label: t('invoice.labels.charge')
      cell: extend:
        template: _.template(
         """<input class="form-control fs-input-num grd-input" type="text" name="value"
            value=<%= value %> autocomplete="off" data-toggle="currency" data-input="true""
           <input/>"""
        )

        events:
          'el:rendered' : (event) =>
            el = Dom.getEl(event.currentTarget).find('input[data-input="true"]')[0]
            @_initFormatter(el)

          'change input[data-input="true"]' : (event) ->
            @model.set('value', event.currentTarget.value)

      formatter: (rawData, model) ->
        value: formatCurr(rawData)
    ,
      label: ''
      cell: extend:
        template: _.template(
         """<div class="pull-right">
              <a class=href="javascript:void(0);" data-remove="true">
                <button type="button" class="btn btn-default btn-sm">
                  <i class="fas fa-times mr-sm"></i> <%= t('general.buttons.delete') %>
                </button>
              </a>
            </div"""
        )

        events:
          'click a[data-remove="true"]' : () ->
            triggerMethod('remove:service', @model)

    ]

    @grid = new GridCmp({
      el: '#grid'
      columns: columns
      collection: @model.get('invoice_services')
      allowPagination: false,
      emptyText: t("invoice.messages.no_services_added")
    })

    @listenTo(@grid, 'grid:add', @onSumFinalCharge)
    @listenTo(@grid, 'grid:remove', @onSumFinalCharge)
    @listenTo(@grid, 'grid:change', @onSumFinalCharge)

    return

  showPatientInfo: (patientModel) ->
    view = new Marionette.View({
      template: patientRegion
      model: patientModel
    })

    @showChildView('patientRegion', view)

    return

  onSumFinalCharge: (model, collection) ->
    sum = @_sumValue(collection.toJSON())

    model.set('value', formatCurr(model.get('value')))
    @ui.total.text(formatCurr(sum))

  onAddService: () ->
    select = @selects['#service-sel']
    services = @model.get("services")

    id = select.getValue()
    obj = _.find(services, (service) =>
      String(service.id) == id
    )

    if !obj then return

    _obj = _.pick(obj, 'name', 'value')
    _obj = _.extend(_obj, {
      id: _.uniqueId('srvc'),
      reference_id: obj.id,
      service_value: obj.value
    })

    select.setValue('')

    model = new Backbone.Model(_obj)
    @grid.addElement(model)

  onRemoveService: (model) ->
    @grid.removeElement(model)

  onSaveClick: (event) ->
    event.preventDefault()

    collection = @grid.getCollection()
    @model.set('invoice_services', collection.toJSON())

    @triggerMethod('invoice:save', @)

  _sumValue: (items) ->
    _.reduce(items,
      (memo, item) ->
        add(memo, item.value)
      , 0)
