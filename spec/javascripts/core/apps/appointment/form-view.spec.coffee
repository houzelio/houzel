import FormView from 'javascripts/core/apps/appointment/form-view'

describe("Appointment Form View", () ->
  MyRegion = Marionette.Region.extend({
    el: '#main-region'
  })

  beforeEach ->
    myModel = new Backbone.Model({
      patients: [{id: 5, name: "Elijah Hoppe"}, {id: 7, name: "Sofia Grimes"}]
      examiners: [{id: 1, name: "Joseane Fogaça"}, {id: 4, name: "Luccas Marks"}]
      patient_id: 7
    })

    @myRegion = new MyRegion
    @myView = new FormView {model: myModel }

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
        patients: [{id: 5, name: "Elijah Hoppe"}, {id: 7, name: "Sofia Grimes"}]
        examiners: [{id: 1, name: "Joseane Fogaça"}, {id: 4, name: "Luccas Marks"}]
        patient_id: 7
        examiner_id: 4
      })

      @myView = new FormView {model: myModel}

      spyOn(@myView, '_showPickers').and.callThrough()
      spyOn(@myView, '_showSelects').and.callThrough()

      @myRegion.show(@myView)

    it("shows the select components", () ->
      expect(@myView._showSelects).toHaveBeenCalled()
    )

    it("shows the picker components", () ->
      expect(@myView._showPickers).toHaveBeenCalled()
    )

    it("should show the corresponding patient", () ->
      expect(@myView.$el.find('#patient_sel_chosen')).toContainHtml('<span>Sofia Grimes</span>')
    )

    it("should show the corresponding examiner", () ->
      expect(@myView.$el.find('#examiner_sel_chosen')).toContainHtml('<span>Luccas Marks</span>')
    )
  )

  describe("Events", () ->
    beforeEach ->
      @myObject = new Marionette.MnObject
      @spy = jasmine.createSpyObj('spy', ['schedule'])

      @myView.render()

    it("triggers the Schedule event", () ->
      @myObject.listenTo(@myView, 'appointment:schedule', @spy.schedule)
      @myView.$el.find('#schedule-btn').click()
      expect(@spy.schedule).toHaveBeenCalled()
    )
  )
)
