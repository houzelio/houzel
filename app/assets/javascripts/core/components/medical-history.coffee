import { t } from 'helpers/i18n'
import Component from 'javascripts/api/component'
import GridCmp from './grid'
import DialogCmp from './dialog'
import template from './templates/medical-history/main.pug'

MainView = Marionette.View.extend({
  template: template
  tagName: 'div'
  className: 'mclhs-cmp'

  onAttach: () ->
    @grid.showView()
    @_removeHeader()

  initialize: (options) ->
    @_buildGrid()

  _buildGrid: () ->
    columns = [
      label: ''
      cell: extend:
        template: _.template(
         """<div class='container-fluid'>
              <div class='row'>
                <span class='grd-heading grd-date'><%= mom(start_date).format('L') %></span>
              </div>
              <div class='row mt-lg'>
                <span class='grd-heading'><%= t("mcl-history.labels.complaint") %></span>
                <div class='grd-text'>
                  <%= (!!complaint.trim()) ? complaint : t("general.messages.empty_set") %>
                </div>
              </div>
              <div class='row mt-lg'>
                <span class='grd-heading'><%= t("mcl-history.labels.diagnosis") %></span>
                <div class='grd-text'>
                  <%= (!!diagnosis.trim()) ? diagnosis : t("general.messages.empty_set") %>
                </div>
              </div>
            </div>"""
        )

      formatter: (rawData, model) ->
        model.toJSON()
    ]

    @grid = new GridCmp({
      el: '#grid'
      columns: columns
      collection: @getOption("mclHistoryCollection"),
      emptyText: t("mcl-history.messages.no_history_available")
    })

    return

  _removeHeader: () ->
    $("thead").remove()

})

ViewOptions = [
  'mclHistoryCollection'
]

export default Component.extend({
  viewClass: MainView

  initialize: (options) ->
    @mergeIntoOption('viewOptions', options, ViewOptions)

    return
})
