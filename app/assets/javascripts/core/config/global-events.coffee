import { AppChan, ObjChan } from 'channels'
import Routes from 'helpers/routes'
import logger from 'js-logger'

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
AppChan.reply("user:signout", () ->
  $.ajax(
    url: Routes.destroy_user_session_path(),
    contentType: 'application/json',
    type: 'DELETE',
    dataType: 'json'
    statusCode:
      401: () ->
        location.assign(Routes.new_user_session_path())
  )
)
