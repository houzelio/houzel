import { AppChan } from 'channels'
import { patient_index_path, patient_path } from 'routes'
import { hzSignInAltSolid } from 'houzel-icons/svg-icons'
import { t } from 'helpers/i18n'
import getTemplate from 'common/templates'
import mom from 'moment'
import GridCmp from 'components/grid'
import MclHistoryCmp from 'components/medical-history'
import LayoutBehavior from 'behaviors/layout'
import template from './templates/show.pug'

export default class extends Marionette.View
  template: template
  tagName: "div"
  className: "content-wrapper"

  behaviors:
    Layout:
      behaviorClass: LayoutBehavior
      view: 'application'

  regions:
    mclHistoryRegion: '#mcl-history-region'

  templateContext:
    route: () ->
      patient_index_path()

  initialize: (options) ->
    @_buildGrid()

  onAttach: () ->
    @_showMclHistory()
    @grid.showView()

  _buildGrid: () ->
    patient_id = @model.get('id')

    columns = [
      name: 'date'
      label: t('appointment.labels.date_of_appointment')
      cell: 'string'
    ,
      name: 'examiner_name'
      label: t('appointment.labels.examiner')
      cell: 'string'
    ,
      label: ''
      cell: extend:
        template: getTemplate('gridActionButtons',
          buttons: [
            title: -> t('visit.buttons.checkin')
            icon: hzSignInAltSolid
          ]
        )
        events:
          'click a[data-click="button_0"]' : () ->
            AppChan.request("visit:edit", @model.get('visit_id'), patient_path(patient_id))
    ]

    @grid = new GridCmp({
      el: '#appointment-grid'
      columns: columns
      collection: @model.get('appointments')
      emptyText: t('appointment.messages.no_appointments')
    })

  _showMclHistory: () ->
    mclHistoryCmp = new MclHistoryCmp({
      mclHistoryCollection: @mclHistoryCollection
    })

    mclHistoryCmp.showViewIn(@, 'mclHistoryRegion')

    return
