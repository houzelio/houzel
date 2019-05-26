import { initDomEvents } from './dom-events'
import { initBackbone } from './backbone'
import { initMixin } from 'javascripts/api/mixin'

export initConfig = () ->
  initDomEvents()
  initBackbone()
  initMixin()
