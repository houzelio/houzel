import { AppChan } from 'channels'
import { t } from 'helpers/i18n'
import Routes from 'helpers/routes'
import GridCmp from 'components/grid'
import LayoutBehavior from 'behaviors/layout'
import template from './templates/list.pug'

export default class extends Marionette.View
  template: template
  tagName: "div"
  className: "content-wrapper"

  navigation: "visit"

  behaviors:
    Layout:
      behaviorClass: LayoutBehavior
      view: 'application'

  templateContext:
    route: () ->
      Routes.new_visit_path()

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
            AppChan.request("visit:edit", @model.get('id'))
    ]

    @grid = new GridCmp({
      el: '#grid'
      columns: columns
      collection: @collection
    })
