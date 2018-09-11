import Component from 'javascripts/api/component'
import GridCmp from './grid'
import DialogCmp from './modal-dialog'
import templateMain from './templates/medical-history/main.pug'
import templateTitle from './templates/medical-history/title.pug'
import templateMessage from './templates/medical-history/message.pug'

MainView = Marionette.View.extend({
  template: templateMain
  tagName: 'div'
  className: 'mclhs-cmp'

  onAttach: () ->
    @grid.showView()

  initialize: (options) ->
    @collection = options.mclHistoryCollection
    @_buildGrid()

  _buildGrid: () ->
    _this = @

    columns = [
      formatter: (rawData, model) ->
        model.toJSON()

      cell: extend:
        template: _.template(
         """<div>
              <a href='javascript:void(0);' class='font-weight-300'>
                <span class='font-18'><%= mom(calendar.start_date).format('L') %></span>
                &nbsp
                <%= mom(calendar.start_date).format('HH[h]mm') %> - <%= mom(calendar.end_date).format('HH[h]mm') %>
              </a>
              <% if (!!visit.chief_complaint.trim()) { %>
                <h5 class="mb-sm"><%= t("visit.labels.chief_complaint") %></h5>
                <span class="font-weight-300"><%= visit.chief_complaint %></span>
              <% } %>
              <% if (!!visit.diagnosis.trim()) { %>
                <h5 class="mb-sm"><%= t("visit.labels.diagnosis") %></h5>
                <span class="font-weight-300"><%= visit.diagnosis %></span>
              <% } %>
           </div>"""
        )

        events:
          'click a': () ->
            _this.triggerMethod("shown:history", @model)
    ]

    @grid = new GridCmp({
      el: '#grid'
      columns: columns
      collection: @collection
    })

    return

})

ViewOptions = [
  'mclHistoryCollection'
]

export default Component.extend({

  viewClass: MainView

  viewEvents:
    'shown:history': 'onShowHistory'

  initialize: (options) ->
    @mergeIntoOption('viewOptions', options, ViewOptions)

    return

  onShowHistory: (model) ->
    data = model.toJSON()

    dialog = new DialogCmp({
      title: templateTitle(data),
      onEscape: true,
      backdrop: true
    })

    dialog.show('dialog', templateMessage(data))

    return

})
