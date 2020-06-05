import FormView from 'javascripts/core/apps/profile/form-view'

describe("Profile Form View", () ->
  MyRegion = Marionette.Region.extend({
    el: '#setting-region'
  })

  beforeEach ->
    setFixtures(__html__['setting-region.html'])

  beforeEach ->
    @myRegion = new MyRegion
    @myView = new FormView {model: new Backbone.Model }

  describe("after initializing", () ->
    it("should exist", () ->
      expect(@myView).toBeTruthy()
    )
  )

  describe("when attaching", () ->
    beforeEach ->
      spyOn(@myView, '_showPickers').and.callThrough()
      spyOn(@myView, '_showSelects').and.callThrough()

      @myRegion.show(@myView)

    it("shows the picker components", () ->
      expect(@myView._showPickers).toHaveBeenCalled()
    )

    it("shows the select components", () ->
      expect(@myView._showSelects).toHaveBeenCalled()
    )

    it("should show the corresponding locale", () ->
      expect(@myView.$el.find('#language-sel option:selected')).toHaveValue('en')
    )
  )

  describe("Events", () ->
    beforeEach ->
      @myObject = new Marionette.MnObject
      @spy = jasmine.createSpyObj('spy', ['save'])

      @myView.render()

    it("triggers the Save event", () ->
      @myObject.listenTo(@myView, 'profile:general:save', @spy.save)
      @myView.$el.find('#save-btn').click()
      expect(@spy.save).toHaveBeenCalled()
    )
  )
)
