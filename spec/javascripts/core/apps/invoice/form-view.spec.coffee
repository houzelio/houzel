import FormView from 'javascripts/core/apps/invoice/form-view'

describe("Invoice Form View", () ->
  MyRegion = Marionette.Region.extend({
    el: '#main-region'
  })

  beforeEach ->
    @myServices = [{id: 2, name: "Check in", value: 109.99}, {id: 3, name: "Exam Lab", value: 99.99}]
    myModel = new Backbone.Model({
      patients: [{id: 5, name: "Elijah Hoppe"}, {id: 7, name: "Sofia Grimes"}]
      services: @myServices
      invoice_services: [{id: 1, name: "Exam Lab", value: 104.99, reference_id: 3}]
    })

    @myRegion = new MyRegion
    @myView = new FormView {model: myModel }

  describe("after initializing", () ->
    it("should exist", () ->
      expect(@myView).toBeTruthy()
    )

    it("should instance a new grid", () ->
      expect(@myView.grid).toBeTruthy()
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
      spyOn(@myView, '_showPickers').and.callThrough()
      spyOn(@myView, '_showSelects').and.callThrough()
      spyOn(@myView.grid, 'showView').and.callThrough()

      @myRegion.show(@myView)

    it("shows the picker components", () ->
      expect(@myView._showPickers).toHaveBeenCalled()
    )

    it("shows the grid component", () ->
      expect(@myView.grid.showView).toHaveBeenCalled()
    )

    it("should show the elements when it exists on DOM", () ->
      expect(@myView.$el.find('.table td').closest('tr').length).toBe(2)
    )

    describe("with a patient", () ->
      it("shows the patient's information", () ->
        myModel = new Backbone.Model({
          id: 1
          patient: {name: "Elijah Hoppe", address: "LoremLorem"}
          patient_id: 5
          services: @myServices
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
  )

  describe("Events", () ->
    beforeEach ->
      @myObject = new Marionette.MnObject
      @spy = jasmine.createSpyObj('spy', ['save'])

      @myView.render()

    it("triggers the Save event", () ->
      @myObject.listenTo(@myView, 'invoice:save', @spy.save)
      @myView.$el.find('#save-btn').click()
      expect(@spy.save).toHaveBeenCalled()
    )
  )

  describe("handling services", () ->
    addService = (value, myView) ->
      myView.selects['#service-sel'].setValue(value)
      myView.$el.find('#service-btn').click()

    beforeEach ->
      @myRegion.show(@myView)

    it("should add a service to the invoice", () ->
      addService(2, @myView)

      expect(@myView.$el.find('#grid td').closest('tr').length).toBe(2)
      expect(@myView.$el.find('#grid')).toContainText("Check in")
      expect(@myView.$el.find('#total-td')).toHaveText('214.98')
    )

    it("should add services as many as possible", () ->
      addService(2, @myView)
      addService(2, @myView)
      addService(3, @myView)
      addService(2, @myView)

      expect(@myView.$el.find('#grid td').closest('tr').length).toBe(5)
      expect(@myView.$el.find('#grid td').closest('tr:contains("Check in")').length).toBe(3)
      expect(@myView.$el.find('#grid td').closest('tr:contains("Exam Lab")').length).toBe(2)
      expect(@myView.$el.find('#total-td')).toHaveText('534.95')
    )

    it("should remove a service from the invoice", () ->
      @myView.$el.find('#grid td:first').closest('tr').find('a[data-remove="true"]').click()
      expect(@myView.$el.find('#grid td:first').closest('tr')).toHaveClass('empty')
      expect(@myView.$el.find('#total-td')).toHaveText('0.00')
    )
  )
)
