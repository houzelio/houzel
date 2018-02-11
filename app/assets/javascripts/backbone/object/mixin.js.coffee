import { mergeOptions} from '../util/options'
import {
  getPrototypeOf,
  setPrototypeOf
} from '../util/props'

parseMixin = (klass) ->
  proto = getPrototypeOf(klass)
  mixins = _.pick(proto, 'mixins')

  proto = mergeOptions(proto, mixins)
  setPrototypeOf(klass, proto)

  klass

initMixin = (Backbone, Marionette) ->
  components = [Backbone.Model, Backbone.Collection, Backbone.Router,
    Backbone.View, Marionette.ItemView]

  _.each(components, (klass) ->
    klass.prototype = mergeOptions(klass.prototype, preinitialize: ->
      if @mixins
        parseMixin(@)
    )
  )

  return

export { initMixin }
