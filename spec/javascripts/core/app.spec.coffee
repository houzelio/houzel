import App from "javascripts/core/app"

describe("App", () ->
  beforeEach ->
    @phrases = json: en: hello: 'Hello'
    @app = new App(strings: @phrases)

  afterAll ->
    Backbone.history.stop

  describe("::onStart", () ->
    beforeEach ->
      Backbone.history.stop()

    it("calls Backbone.history.start", () ->
      spyOn(Backbone.history, "start")
      @app.start()
      expect(Backbone.history.start).toHaveBeenCalledWith(pushState: true)
    )
  )
)
