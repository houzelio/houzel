import HeaderView from 'javascripts/core/layouts/user/header-view'
import { AppChan } from 'javascripts/core/channels'

describe("User Header View", () ->
  beforeEach ->
    @myView = new HeaderView

  describe("after initializing", () ->
    it("should exist", () ->
      expect(@myView).toBeTruthy()
    )
  )

  describe("Events", () ->
    describe("catching", () ->
      beforeEach ->
        @myView.render()

      it("signs out of account", () ->
        spy = jasmine.createSpy('spy')
        AppChan.reply("user:signout", spy)

        @myView.$el.find('#logout').click()
        expect(spy).toHaveBeenCalled()
      )
    )
  )
)
