import PageableCollection from "backbone.paginator"

Model = Backbone.Model.extend({})

Collection = PageableCollection.extend({
  model: Model

  state:
    pageSize: 10

  queryParams:
    sortKey: "order"

  parseState: (resp, queryParams, state, options) ->
    totalRecords: resp.total_count

  parseRecords: (resp, options) ->
    resp.items
})

Entity = Marionette.MnObject.extend({
  cidPrefix: 'mne'

  modelClass: Model

  collectionClass: Collection

  constructor: (options) ->
    Marionette.MnObject.prototype.constructor.apply(@, arguments)

    modelOptions = _.pick(@, 'urlRoot', 'validation')
    if !_.isEmpty(modelOptions) then @modelClass = @modelClass.extend(modelOptions)

    collectionOptions = _.pick(@, 'url')
    if !_.has(@collectionClass.prototype, 'url')
      collectionOptions = _.defaults(collectionOptions, url: @urlRoot)

    if !_.isEmpty(collectionOptions) then @collectionClass = @collectionClass.extend(collectionOptions)

    return

  create: (attrs, options) ->
    model = @_getModel(attrs, options)

    if _.has(options, 'urlRoot')
      urlRoot = model.urlRoot
      model.urlRoot = _.result(options, 'urlRoot')

    if (_.result(options, 'fetch')) then model.fetch()
    if urlRoot then model.urlRoot = urlRoot

    model

  get: (id, options) ->
    model = @_getModel(id: id, _.omit(options, 'fetchOptions'))

    fetchOptions = @_fetchOptions(options)
    model.fetch(fetchOptions)
    model

  getList: (options) ->
    collection = @_getCollection(null, _.omit(options, 'fetchOptions'))

    fetchOptions = @_fetchOptions(options)
    collection.fetch(fetchOptions)
    collection

  _getModel: (attrs, options) ->
    ModelClass = @modelClass
    new ModelClass(attrs, options)

  _getCollection: (attrs, options) ->
    CollectionClass = @collectionClass
    new CollectionClass(attrs, options)

  _fetchOptions: (options) ->
    if _.has(options, 'fetchOptions')
      fetchOptions = _.result(options, 'fetchOptions')
      if !_.isEmpty(fetchOptions) then return { data: fetchOptions }

})

export default Entity
