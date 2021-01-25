import PasswordView from 'javascripts/core/apps/profile/password-view'

describe("Profile Password View", () ->
  beforeEach ->
    @myView = new PasswordView {model: new Backbone.Model }

  describe("after initializing", () ->
    it("should exist", () ->
      expect(@myView).toBeTruthy()
    )
  )

  describe("Events", () ->
    beforeEach ->
      @myObject = new Marionette.MnObject
      @spy = jasmine.createSpyObj('spy', ['save'])

      @myView.render()

    it("triggers the Save event", () ->
      @myObject.listenTo(@myView, 'profile:password:save', @spy.save)
      @myView.$el.find('#save-btn').click()
      expect(@spy.save).toHaveBeenCalled()
    )
  )
)
