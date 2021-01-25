import FormView from 'javascripts/core/apps/service/form-view'

describe("Service Form View", () ->
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
        id: 2
        name: "Exam Lab"
        category: "other"
        value: 99.9
      })

      @myView = new FormView {model: myModel}

      spyOn(@myView, '_initFormatters').and.callThrough()
      spyOn(@myView, '_showSelects').and.callThrough()

      @myRegion.show(@myView)

    it("shows the picker components", () ->
      expect(@myView._initFormatters).toHaveBeenCalled()
    )

    it("shows the select components", () ->
      expect(@myView._showSelects).toHaveBeenCalled()
    )

    it("should show the corresponding category", () ->
      expect(@myView.$el.find('#category-sel option:selected')).toHaveValue('other')
    )
  )

  describe("Events", () ->
    beforeEach ->
      @myObject = new Marionette.MnObject
      @spy = jasmine.createSpyObj('spy', ['save'])

      @myView.render()

    it("triggers the Save event", () ->
      @myObject.listenTo(@myView, 'service:save', @spy.save)
      @myView.$el.find('#save-btn').click()
      expect(@spy.save).toHaveBeenCalled()
    )
  )
)
