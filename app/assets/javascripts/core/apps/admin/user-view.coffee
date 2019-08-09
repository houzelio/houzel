import { t } from 'helpers/i18n'
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
             <div class="pull-right">
               <a class=href="javascript:void(0);" data-remove="true">
                 <button type="button" class="btn btn-default btn-sm">
                   <i class="fas fa-times mr-sm"></i> <%= t('admin.buttons.access_revoke') %>
                 </button>
               </a>
             </div>
            <% } %>"""
        )

        events:
          'click a[data-remove="true"]' : () ->
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
