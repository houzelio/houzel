import { AppChan } from 'channels'
import { new_appointment_path, appointment_index_path } from 'routes'
import { hzSignInAltSolid } from 'houzel-icons/svg-icons'
import { t } from 'helpers/i18n'
import getTemplate from 'common/templates'
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

  events:
    'click a[data-toggle=tab]' : 'onAnchorDataToggle'

  templateContext:
    route: () ->
      new_appointment_path()

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
        template: getTemplate('gridActionButtons',
          buttons: [
            title: -> t('visit.buttons.checkin')
            icon: hzSignInAltSolid
          ,
            title: -> t('general.buttons.edit')
          ]
        )
        events:
          'click a[data-click="button_0"]' : () ->
            AppChan.request("visit:edit", @model.get('visit_id'), appointment_index_path())

          'click a[data-click="button_1"]' : () ->
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
