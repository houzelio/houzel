@Houzel = do (Backbone, Marionette) ->

  App = new Marionette.Application

  App.on "start", ->
    if Backbone.history
      Backbone.history.start
        pushState: true

  App
