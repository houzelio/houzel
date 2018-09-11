import { ObjChan } from 'channels'
import logger from 'js-logger'

export initFetch = () ->
  ObjChan.reply "when:fetched", (object, callback) ->
    xhrs = _.chain([object]).flatten().pluck("_fetch").value()

    $.when(xhrs...)
      .done ->
        try
          callback()
        catch error
           logger.error(error)

        return
