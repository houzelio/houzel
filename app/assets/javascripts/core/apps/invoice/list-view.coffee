import { AppChan } from 'channels'
import { new_invoice_path } from 'routes'
import { t } from 'helpers/i18n'
import { formatCurr } from 'helpers/numeral'
import mom from 'moment'
import GridCmp from 'components/grid'
import LayoutBehavior from 'behaviors/layout'
import template from './templates/list.pug'

export default class extends Marionette.View
  template: template
  tagName: "div"
  className: "content-wrapper"

  behaviors:
    Layout:
      behaviorClass: LayoutBehavior
      view: 'application'

  templateContext:
    route: () ->
      new_invoice_path()

  initialize: (options) ->
    @_buildGrid()

  onAttach: () ->
    @grid.showView()

  _buildGrid: () ->
    columns = [
      name: 'patient_name'
      label: t('general.labels.name')
      cell: 'string'
    ,
      name: 'bill_date'
      label: t('invoice.labels.billed_date')
      cell: 'string'
    ,
      name: ''
      label: t('invoice.labels.total')
      cell: 'string'
      formatter: (rawData, model) ->
        formatCurr(model.get('total'))
    ,
      label: ''
      cell: extend:
        template: _.template(
         """<div class="pull-right">
              <a href="javascript:void(0);" data-show="true">
                <button type="button" class="btn btn-default btn-sm">
                  <%= t('general.buttons.edit') %>
                </button>
              </a>
            </div"""
        )
        events:
          'click a[data-show="true"]' : () ->
            AppChan.request("invoice:edit", @model.get('id'))
    ]

    @grid = new GridCmp({
      el: '#grid'
      columns: columns
      collection: @collection
    })
