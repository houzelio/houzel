import FormView from 'javascripts/core/apps/visit/form-view'
import mom from 'moment'

describe("Visit Form View", () ->
  MyRegion = Marionette.Region.extend({
    el: '#main-region'
  })

  beforeEach ->
    myModel = new Backbone.Model({
      patients: [{id: 5, name: "Elijah Hoppe"}, {id: 7, name: "Sofia Grimes"}]
    })

    @myMedicalHistory = [
      {start_date: '2004-04-14 08:30', complaint: "Cough, Chest Pain" , diagnosis: "Asthma"},
      {start_date: '2009-10-22 14:20', complaint: "Fever, Fatigue" , diagnosis: "Influenza"}
    ]

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
      expect(@myView.$el.find('.content-btn').children().length).toBe(1)
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

    describe("with a patient", () ->
      it("shows the patient's information", () ->
        myModel = new Backbone.Model({
          id: 1
          patient: {name: "Elijah Hoppe", observation: "Sint ratione est autem dolor"}
          patient_id: 5
        })

        myView = new FormView {model: myModel}
        @myRegion.show(myView)

        expect(myView.$el.find('#patient-sel')).not.toBeInDOM()
        expect(myView.$el).toContainText("Elijah Hoppe")
      )
    )

    describe("without a patient", () ->
      it("shows the select components", () ->
        expect(@myView._showSelects).toHaveBeenCalled()
      )
    )

    describe("with a medical history", () ->
      it("shows the patient's medical history", () ->
        myModel = new Backbone.Model({
          id: 1
          patient: {name: "Elijah Hoppe", observation: "Sint ratione est autem dolor"}
          patient_id: 5
        })

        myView = new FormView({
          model: myModel
          mclHistoryCollection: new Backbone.Collection(@myMedicalHistory)
        })

        @myRegion.show(myView)
        expect(myView.$el.find('#mcl-history-region')).not.toBeEmpty()
      )
    )

    describe("without a medical history", () ->
      it("shows an empty history", () ->
        expect(@myView.$el.find('#mcl-history-region')).toBeEmpty()
      )
    )

    describe("Events", () ->
      beforeEach ->
        @myObject = new Marionette.MnObject
        @spy = jasmine.createSpyObj('spy', ['save'])

        @myView.render()

      it("triggers the Save event", () ->
        @myObject.listenTo(@myView, 'visit:save', @spy.save)
        @myView.$el.find('#save-btn').click()
        expect(@spy.save).toHaveBeenCalled()
      )
    )

    describe("::onAnchorPickerClick", () ->
      it("should update the date", () ->
        @myView.$el.find('#checkin-pickr').val('')
        @myView.$el.find('#checkin-pickr').next().click()
        @myView.$el.find('#checkout-pickr').next().click()

        getDate = (id) =>
          mom(@myView.pickers[id].getValue(), 'YYYY-MM-DD HH:mm')

        checkInDate = getDate('#checkin-pickr')
        checkOutDate = getDate('#checkout-pickr')

        expect(mom(checkInDate).isValid()).toBeTruthy()
        expect(mom(checkOutDate).isValid()).toBeTruthy()
      )
    )
  )
)
