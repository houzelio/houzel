import { AppChan } from 'channels'
import { t } from 'helpers/i18n'
import mom from 'moment'
import Routes from 'helpers/routes'
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

  events:
    'click a[data-toggle=tab]' : 'onAnchorDataToggle'

  templateContext:
    route: () ->
      Routes.new_appointment_path()

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
      name: 'examiner_name'
      label: t('appointment.labels.examiner')
      cell: 'string'
    ,
      name: ''
      label: t('appointment.labels.date_of_appointment')
      cell: 'string'
      formatter: (rawData, model) ->
        "#{model.get('date')} | #{model.get('start_time')} - #{model.get('end_time')}"
    ,
      label: ''
      cell: extend:
        template: _.template(
         """<div class="pull-right">
              <a href="javascript:void(0);" data-check="true">
                <button type="button" class="btn btn-default btn-sm">
                  <i class=" la la-sign-in mr-sm"></i> <%= t('visit.buttons.checkin') %>
                </button>
              </a>
              <a class="ml-sm" href="javascript:void(0);" data-show="true">
                <button type="button" class="btn btn-default btn-sm">
                  <%= t('general.buttons.edit') %>
                </button>
              </a>
            </div"""
        )
        events:
          'click a[data-check="true"]' : () ->
            AppChan.request("visit:edit", @model.get('visit_id'), Routes.appointment_index_path())

          'click a[data-show="true"]' : () ->
            AppChan.request("appointment:edit", @model.get('id'))
    ]

    @grid = new GridCmp({
      el: '#grid'
      columns: columns
      collection: @collection
    })

  onAnchorDataToggle: (event) ->
    intvl = Dom.getEl(event.currentTarget).attr('href').replace('#', '')

    if intvl in ['day', 'week', 'month']
      params =
        start_date: mom().startOf(intvl).format('YYYY-MM-DD HH:mm')
        end_date: mom().endOf(intvl).format('YYYY-MM-DD HH:mm')

    @grid.filterBy(params)
