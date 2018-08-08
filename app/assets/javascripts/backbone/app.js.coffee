import { initConfig } from './config/index'
import { initApps } from './apps/index'

App = class extends Marionette.Application
  initialize: (options) ->
    initApps()

  onStart: (app, options) ->
      Backbone.history.start
        pushState: true

initConfig()

export default App
