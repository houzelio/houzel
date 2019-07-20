import { ObjChan } from 'channels'
import { showNotification } from 'helpers/notification'
import Validation from 'backbone-validation'
import logger from 'js-logger'

#Mix in validation on the model's prototype
_.extend(Backbone.Model.prototype, Validation.mixin)

#Check the fetched entity for errors
ObjChan.reply("when:fetched", (object, callback) ->
  xhrs = _.chain([object]).flatten().pluck("_fetch").value()

  $.when(xhrs...)
    .done ->
      try
        callback()
      catch error
        logger.error(error)
)


patchSync = (cache = false) ->
  Backbone.$.ajaxSetup
    cache: false

  actions =
    beforeSend: () ->
      @trigger "sync:start", @

    complete: (jqXHR, textStatus) ->
      message = _.property(['responseJSON', 'message'])(jqXHR)
      if message then showNotification(message)

      @trigger "sync:stop", @

  _sync = Backbone.sync

  Backbone.sync = (method, entity, options = {}) ->
    _.defaults(options,
      beforeSend: _.bind(actions.beforeSend, entity)
      complete: _.bind(actions.complete, entity)
    )

    sync = _sync(method, entity, options)
    if !entity._fetch and method is "read"
      entity._fetch = sync

export initBackbone = () ->
  patchSync()
