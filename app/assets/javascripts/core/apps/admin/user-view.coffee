import { hzTimesSolid } from 'houzel-icons/svg-icons'
import { t } from 'helpers/i18n'
import getTemplate from 'common/templates'
import GridCmp from 'components/grid'
import DialogCmp from 'components/box-dialog'
import template from './templates/user.pug'

export default class extends Marionette.View
  template: template
  tagName: "div"

  initialize: (options) ->
    @_buildGrid()

    return

  onAttach: () ->
    @grid.showView()

  _buildGrid: () ->
    triggerMethod = _.bind(@triggerMethod, @)

    columns = [
      name: 'name'
      label: ''
      cell: 'string',
    ,
      label: ''
      cell: extend:
        template: _.template(
         """<% if (role_name) { %>
             <span class="label label-info">
               <%= role_name %>
             </span>
            <% }  %>
         """
        )
      formatter: (rawData, model) ->
        model.toJSON()
    ,
      label: '',
      cell: extend:
        template: _.template(
         """<% if (role_name != "owner" && user.admin) { %>
             #{ getTemplate('gridActionButtons',
               buttons: [
                 title: -> t('admin.buttons.access_revoke')
                 icon: hzTimesSolid
               ]
             )() }
            <% } %>"""
        )
        events:
          'click a[data-click="button_0"]' : () ->
            dialog = new DialogCmp
            @listenTo(dialog, 'dialog:action:result', (ok) =>
              if ok then triggerMethod('admin:remove:user', @model, @model.collection)
            )

            dialog.confirm(t('admin.messages.revoke_access', name: @model.get("name")))

      formatter: (rawData, model) ->
        _.extend({user: gon.user}, model.toJSON())
    ]

    @grid = new GridCmp({
      el: '#grid'
      columns: columns
      collection: @collection
      allowPagination: false
    })

    return
