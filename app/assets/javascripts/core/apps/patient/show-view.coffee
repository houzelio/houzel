import { t } from 'helpers/i18n'
import mom from 'moment'
import Routes from 'helpers/routes'
import GridCmp from 'components/grid'
import MclHistoryCmp from 'components/medical-history'
import LayoutBehavior from 'behaviors/layout'
import template from './templates/show.pug'

export default class extends Marionette.View
  template: template
  tagName: "div"
  className: "content-wrapper"

  navigation: "patient"

  behaviors:
    Layout:
      behaviorClass: LayoutBehavior
      view: 'application'

  regions:
    mclHistoryRegion: '#mcl-history-region'

  templateContext:
    route: () ->
      Routes.patient_index_path()

  initialize: (options) ->
    @_buildGrid()

  onAttach: () ->
    @_showMclHistory()
    @grid.showView()

  _buildGrid: () ->
    columns = [
      name: 'start_date'
      label: t('appointment.labels.date_of_visit')
      cell: 'string'
      formatter: (rawData, model) ->
        mom(rawData).format('L LT')
    ,
      name: 'examiner'
      label: t('appointment.labels.examiner')
      cell: 'string'
    ,
      label: ''
      cell: extend:
        template: _.template(
         """<div class="pull-right">
              <a class=href="javascript:void(0);" data-check="true">
                <button type="button" class="btn btn-default btn-sm">
                  <i class=" la la-sign-in mr-sm"></i> <%= t('general.buttons.checkin') %>
                </button>
              </a>
            </div"""
        )
    ]

    @grid = new GridCmp({
      el: '#appointment-grid'
      columns: columns
      collection: @model.get('appointments')
    })

  _showMclHistory: () ->
    mclHistoryCmp = new MclHistoryCmp({
      mclHistoryCollection: @mclHistoryCollection
    })

    mclHistoryCmp.showViewIn(@, 'mclHistoryRegion')

    return
