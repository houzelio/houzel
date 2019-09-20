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
    ModelClass = @modelClass
    model = new ModelClass(attrs, options)

    if _.has(options, 'urlRoot')
      urlRoot = model.urlRoot
      model.urlRoot = _.result(options, 'urlRoot')


    if (_.result(options, 'fetch')) then model.fetch()
    if urlRoot then model.urlRoot = urlRoot

    model

  get: (id, options) ->
    ModelClass = @modelClass
    model = new ModelClass(id: id, _.omit(options, 'fetchOptions'))

    fetchOptions = _.pick(options, 'fetchOptions')
    model.fetch(fetchOptions)
    model

  getList: (options) ->
    CollectionClass = @collectionClass
    collection = new CollectionClass(null, _.omit(options, 'fetchOptions'))

    fetchOptions = _.pick(options, 'fetchOptions')
    collection.fetch(fetchOptions)
    collection

})

export default Entity
