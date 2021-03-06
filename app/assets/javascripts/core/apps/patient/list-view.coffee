import { AppChan } from 'channels'
import { new_patient_path } from 'routes'
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

  templateContext:
    route: () ->
      new_patient_path()

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
      name: 'phone'
      label: t('general.labels.phone')
      cell: 'string'
    ,
      name: 'birthday'
      label: t('patient.labels.age')
      cell: 'string'
      formatter: (rawData, model) ->
        if _.isEmpty(rawData) then return

        mom().diff(rawData, 'years')
    ,
      label: ''
      cell: extend:
        template: getTemplate('gridActionButtons',
          buttons: [
            title: -> t('general.buttons.view')
          ,
            title: -> t('general.buttons.edit')
          ]
        )
        events:
          'click a[data-click="button_0"]' : () ->
            AppChan.request("patient:show", @model.get('id'))

          'click a[data-click="button_1"]' : () ->
            AppChan.request("patient:edit", @model.get('id'))
    ]

    @grid = new GridCmp({
      el: '#grid'
      columns: columns
      collection: @collection
    })
