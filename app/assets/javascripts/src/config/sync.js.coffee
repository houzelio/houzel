export initSync = () ->
  Backbone.$.ajaxSetup
    cache: false

  _sync = Backbone.sync

  Backbone.sync = (method, entity, options = {}) ->
    _.defaults options,
      beforeSend: _.bind(actions.beforeSend, entity)
      complete: _.bind(actions.complete, entity)

    sync = _sync(method, entity, options)
    if !entity._fetch and method is "read"
      entity._fetch = sync

  actions =
    beforeSend: ->
      @trigger "sync:start", @

    complete: ->
      @trigger "sync:stop", @
