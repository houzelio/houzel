import MainView from 'javascripts/core/layouts/user/main-view'

describe("User Main View", () ->
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
  )
)
