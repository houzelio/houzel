import { initDomEvents } from './dom-events'
import { initBackbone } from './backbone'
import { initMixin } from 'javascripts/api/mixin'
import "./global-events"

export initConfig = () ->
  initDomEvents()
  initBackbone()
  initMixin()
