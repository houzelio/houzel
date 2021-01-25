import MainView from 'javascripts/core/layouts/application/main-view'

describe("Application Main View", () ->
  beforeEach ->
    @myView = new MainView

  describe("after initializing", () ->
    it("should exist", () ->
      expect(@myView).toBeTruthy()
    )
  )

  describe("after rendering", () ->
    beforeEach ->
      @myView.render()

    it("should show the Header View", () ->
      expect(@myView.getRegion('headerRegion').currentView).toBeDefined()
    )

    it("should show the Side View", () ->
      expect(@myView.getRegion('sideRegion').currentView).toBeDefined()
    )
  )
)
