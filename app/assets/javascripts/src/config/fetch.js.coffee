import Radio from 'backbone.radio'

export initFetch = (channel) ->
  Radio.channel(channel).reply "when:fetched", (object, callback) ->
    xhrs = _.chain([object]).flatten().pluck("_fetch").value()

    $.when(xhrs...).done ->
      callback()
