import { AppChan, ObjChan } from 'channels'
import { destroy_user_session_path, new_user_session_path } from 'routes'
import { showNotification } from 'helpers/notification'
import { initMixin as extendMixin } from 'javascripts/api/mixin'
import Validation from 'backbone-validation'
import NProgress from 'nprogress'
import logger from 'js-logger'

#Mix in validation on the prototype of model
_.extend(Backbone.Model.prototype, Validation.mixin)

extendMixin()

#Turn off loading spinner
NProgress.configure({ showSpinner: false })

Backbone.$.ajaxSetup(cache: false)

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

#Sign out
AppChan.reply("user:signout", (options) ->
  Backbone.ajax(
    url: destroy_user_session_path(),
    contentType: 'application/json',
    type: 'DELETE',
    dataType: 'json',
    data: JSON.stringify(options),
    statusCode:
      401: () ->
        location.assign(new_user_session_path())
  )
)

#Monitor backbone event click
$el = Dom.getEl(document)
$el.on('click', 'a[data-backbone="true"]', (event) ->
  event.preventDefault()
  targetEl = event.currentTarget
  href = Dom.getEl(targetEl).attr('href')

  BbHst = Backbone.history

  ret = BbHst.navigate(href, true)
  if !_.isUndefined(ret) then return

  BbHst.loadUrl(BbHst.fragment)
)

#Override "Backbone.sync" globaly
sync = Backbone.sync
Backbone.sync = (method, entity, options = {}) ->
  _.defaults(options,
    beforeSend: () ->
       entity.trigger "sync:start", entity
       NProgress.start()

    complete: (jqXHR, textStatus) ->
      message = _.property(['responseJSON', 'message'])(jqXHR)
      if message then showNotification(message)

      NProgress.done()
      entity.trigger "sync:stop", entity
  )

  synced = sync(method, entity, options)
  if !entity._fetch and method is "read"
    entity._fetch = synced
