PageableCollection = require("backbone.paginator");
import Radio from 'backbone.radio'

channel = Radio.channel('Object')

channel.reply "when:fetched", (object, callback) ->
  xhrs = _.chain([object]).flatten().pluck("_fetch").value()

  $.when(xhrs...).done ->
    callback()

export default class extends PageableCollection
  state:
    pageSize: 10

  queryParams:
    sortKey: "order"

  parseState: (resp, queryParams, state, options) ->
    totalRecords: resp.total_count

  parseRecords: (resp, options) ->
    resp.items