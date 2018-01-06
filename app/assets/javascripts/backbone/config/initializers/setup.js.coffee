import Radio from 'backbone.radio'

export Configure =
  initialize: (options = channel: 'Object') ->
    _fetch(options.channel)
    _sync()

_fetch = (_channel) ->
  Radio.channel(_channel).reply "when:fetched", (object, callback) ->
    xhrs = _.chain([object]).flatten().pluck("_fetch").value()

    $.when(xhrs...).done ->
      callback()

_sync = (_cache = false) ->
  Backbone.$.ajaxSetup
    cache: _cache

  backboneSync = Backbone.sync

  Backbone.sync = (method, entity, options = {}) ->
    _.defaults options,
      beforeSend: _.bind(actions._beforeSend, entity)
      complete: _.bind(actions._complete, entity)

    sync = backboneSync(method, entity, options)
    if !entity._fetch and method is "read"
      entity._fetch = sync

  actions =
    _beforeSend: ->
      @trigger "sync:start", @

    _complete: ->
      @trigger "sync:stop", @
