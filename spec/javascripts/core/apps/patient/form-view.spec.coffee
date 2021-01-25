import FormView from 'javascripts/core/apps/patient/form-view'

describe("Patient Form View", () ->
  MyRegion = Marionette.Region.extend({
    el: '#main-region'
  })

  beforeEach ->
    @myRegion = new MyRegion
    @myView = new FormView {model: new Backbone.Model }

  describe("after initializing", () ->
    it("should exist", () ->
      expect(@myView).toBeTruthy()
    )
  )

  describe("after rendering", () ->
    beforeEach ->
      @myView.render()

    it("should set the title correctly", () ->
      expect(@myView.$el.find('.content-title').children()).not.toBe('')
    )

    it("should set the link for the button Back properly", () ->
      expect(@myView.$el.find('.content-btn').children().attr("href")).toBeNonEmptyString()
    )
  )

  describe("when attaching", () ->
    beforeEach ->
      myModel = new Backbone.Model({
          id: 5
          name: "Elijah Hoppe"
          blood_type: "O-"
          sex: "female"
      })

      @myView = new FormView {model: myModel}

      spyOn(@myView, '_showPickers').and.callThrough()
      spyOn(@myView, '_showSelects').and.callThrough()

      @myRegion.show(@myView)

    it("shows the picker components", () ->
      expect(@myView._showPickers).toHaveBeenCalled()
    )

    it("shows the select components", () ->
      expect(@myView._showSelects).toHaveBeenCalled()
    )

    it("should show the corresponding values on selects", () ->
      expect(@myView.$el.find('#sex-sel option:selected')).toHaveValue('female')
      expect(@myView.$el.find('#blood-sel option:selected')).toHaveValue('O-')
    )
  )

  describe("Events", () ->
    beforeEach ->
      @myObject = new Marionette.MnObject
      @spy = jasmine.createSpyObj('spy', ['save'])

      @myView.render()

    it("triggers the Save event", () ->
      @myObject.listenTo(@myView, 'patient:save', @spy.save)
      @myView.$el.find('#save-btn').click()
      expect(@spy.save).toHaveBeenCalled()
    )
  )
)
