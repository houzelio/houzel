PageableCollection = require("backbone.paginator");

export default class extends PageableCollection
  state:
    pageSize: 10

  queryParams:
    sortKey: "order"

  parseState: (resp, queryParams, state, options) ->
    totalRecords: resp.total_count

  parseRecords: (resp, options) ->
    resp.items