import { initSync } from './sync'
import { initFetch } from './fetch'
import { initMixin } from '../object/mixin'

export default initConfig = ->
  initSync(Backbone)
  initMixin(Backbone, Marionette)
  initFetch('Object')
