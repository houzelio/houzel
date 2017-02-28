@Houzel.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
	class Entities.PageableCollection extends Backbone.PageableCollection
		state:
			pageSize: 10

		queryParams:
			sortKey: "order"

		parseState: (resp, queryParams, state, options) ->
			totalRecords: resp.total_count

		parseRecords: (resp, options) ->
			resp.items
