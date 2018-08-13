import { ObjChan } from 'channels'

export initFetch = () ->
  ObjChan.reply "when:fetched", (object, callback) ->
    xhrs = _.chain([object]).flatten().pluck("_fetch").value()

    $.when(xhrs...).done ->
      callback()
