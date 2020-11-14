import { initIntl } from './helpers/i18n'
import { initApps } from './apps'
import './config/environment'

App = class extends Marionette.Application
  initialize: (options) ->
    initIntl(options)
    initApps()

    return

  onStart: (app, options) ->
    Backbone.history.start
      pushState: true

export default App
