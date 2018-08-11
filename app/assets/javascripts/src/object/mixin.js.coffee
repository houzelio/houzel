import { mergeOverStrat} from '../util/options'
import {
  getPrototypeOf,
  setPrototypeOf
} from '../util/props'

mixinBuiltIn = (klass) ->
  proto = getPrototypeOf(klass)
  mergeOverStrat(proto, proto, _.keys)

  klass

initMixin = (Backbone, Marionette) ->
  components = [Backbone.View]

  _.each(components, (klass) ->
    klass.prototype.preinitialize = ->
        mixinBuiltIn(@)
    )

  return

export { initMixin }
