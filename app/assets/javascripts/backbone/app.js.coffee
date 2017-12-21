
App = class extends Marionette.Application

    if Backbone.history
      Backbone.history.start
        pushState: true

export default App