import EmailView from 'javascripts/core/apps/profile/email-view'

describe("Profile Email View", () ->
  beforeEach ->
    @myView = new EmailView {model: new Backbone.Model }

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
      @myObject.listenTo(@myView, 'profile:email:save', @spy.save)
      @myView.$el.find('#save-btn').click()
      expect(@spy.save).toHaveBeenCalled()
    )
  )
)
