import { initSync } from './sync'
import { initFetch } from './fetch'
import { initMixin } from 'javascripts/api/mixin'

export initConfig = ->
  initSync()
  initFetch()
  initMixin()
