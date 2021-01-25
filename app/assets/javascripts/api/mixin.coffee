import { mergeStrats } from './utils/strats'
import { getPrototypeOf } from './utils/props'

mixinBuiltIn = (klass) ->
  proto = getPrototypeOf(klass)
  mergeStrats(proto, proto, _.keys)

  proto._isMixed = true

  klass

initMixin = () ->
  components = [Backbone.View]

  _.each(components, (klass) ->
    klass.prototype.preinitialize = ->
      if @mixins && !@_isMixed
        mixinBuiltIn(@)
    )

  return

export { initMixin }
