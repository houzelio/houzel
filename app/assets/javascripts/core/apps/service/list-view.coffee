import { AppChan } from 'channels'
import { t } from 'helpers/i18n'
import { formatCurr } from 'helpers/numeral'
import Routes from 'helpers/routes'
import numeral from 'numeral'
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
      Routes.new_service_path()

  initialize: (options) ->
    @_buildGrid()

  onAttach: () ->
    @grid.showView()

  _buildGrid: () ->
    columns = [
      name: 'name'
      label: t('general.labels.name')
      cell: 'string'
    ,
      label: ''
      cell: extend:
        template: _.template(
         """<div>
             <% if (category == "private") { %>
               <span class="label label-warning">
                 <%= t('service.labels.private') %>
               </span>
             <% } else if (category == "insurance") { %>
               <span class="label label-info">
                 <%= t('service.labels.insurance') %>
               </span>
             <% } else if (category == "other") { %>
               <span class="label label-green">
                 <%= t('service.labels.other') %>
               </span>
             <% } %>
           </div>"""
        )
      formatter: (rawData, model) ->
        model.toJSON()
    ,
      name: 'value'
      label: t('general.labels.value')
      cell: 'string'
      formatter: (rawData, model) ->
        formatCurr(rawData)
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
            AppChan.request("service:edit", @model.get('id'))
    ]

    @grid = new GridCmp({
      el: '#grid'
      columns: columns
      collection: @collection
    })
