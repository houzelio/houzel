import { mergeOverStrat } from './utils/strats'
import { getPrototypeOf } from './utils/props'

mixinBuiltIn = (klass) ->
  proto = getPrototypeOf(klass)
  mergeOverStrat(proto, proto, _.keys)

  klass

initMixin = () ->
  components = [Backbone.View]

  _.each(components, (klass) ->
    klass.prototype.preinitialize = ->
      if @mixins
        mixinBuiltIn(@)
    )

  return

export { initMixin }
