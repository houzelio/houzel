import { AppChan } from 'channels'
import { new_visit_path } from 'routes'
import { t } from 'helpers/i18n'
import getTemplate from 'common/templates'
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
      new_visit_path()

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
      name: 'sex'
      label: t('patient.labels.sex')
      cell: 'string'
      formatter: (rawData, model) ->
        switch rawData
          when 'male' then t('patient.labels.male')
          when 'female' then t('patient.labels.female')
    ,
      name: 'start_date_long'
      label: t('visit.labels.checkin_time')
      cell: 'string'
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
            AppChan.request("visit:edit", @model.get('id'))
    ]

    @grid = new GridCmp({
      el: '#grid'
      columns: columns
      collection: @collection
    })
