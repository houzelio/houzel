import HeaderView from 'javascripts/core/layouts/application/header-view'
import { AppChan } from 'javascripts/core/channels'

describe("Application Header View", () ->
  beforeEach ->
    @myView = new HeaderView

  describe("after initializing", () ->
    it("should exist", () ->
      expect(@myView).toBeTruthy()
    )
  )

  describe('::onAnchorToggleState', () ->
    it("should toggle the class on body", () ->
      @myView.render()

      @myView.$el.find('a[data-toggle-state]').click()
      expect($('body')).toHaveClass('aside-toggled')
      @myView.$el.find('a[data-toggle-state]').click()
      expect($('body')).not.toHaveClass('aside-toggled')
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
