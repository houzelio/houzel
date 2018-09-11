import { initIntl} from './helpers/i18n'
import { initConfig } from './config/index'
import { initApps } from './apps/index'

App = class extends Marionette.Application
  initialize: (options) ->
    initIntl(options)
    initApps()

    return

  onStart: (app, options) ->
    Backbone.history.start
      pushState: true

initConfig()

export default App
