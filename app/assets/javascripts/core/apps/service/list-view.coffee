import { AppChan } from 'channels'
import { new_service_path } from 'routes'
import { t } from 'helpers/i18n'
import { formatCurr } from 'helpers/numeral'
import getTemplate from 'common/templates'
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
      new_service_path()

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
        template: getTemplate('gridActionButtons',
          buttons: [
            title: -> t('general.buttons.edit')
          ]
        )
        events:
          'click a[data-click="button_0"]' : () ->
            AppChan.request("service:edit", @model.get('id'))
    ]

    @grid = new GridCmp({
      el: '#grid'
      columns: columns
      collection: @collection
    })
