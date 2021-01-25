import ListView from 'javascripts/core/apps/invoice/list-view'
import { AppChan } from 'javascripts/core/channels'

describe("Invoice List View", () ->
  MyRegion = Marionette.Region.extend({
    el: '#main-region'
  })

  beforeEach ->
    myCollection = new Backbone.Collection([
      new Backbone.Model({id: 1, patient_name: "Elijah Hoppe", bill_date: "2019-05-22", total: 220.50}),
      new Backbone.Model({id: 2, patient_name: "Sofia Grimes", bill_date: "2018-04-02", total: 187.00})
    ])

    @myView = new ListView {collection: myCollection }

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

    it("should set the link for the button New properly", () ->
      expect(@myView.$el.find('.content-btn').children().attr("href")).toBeNonEmptyString()
    )
  )

  describe("when attaching", () ->
    beforeEach ->
      spyOn(@myView.grid, 'showView').and.callThrough()

      @myRegion = new MyRegion
      @myRegion.show(@myView)

    it("shows the grid component", () ->
      expect(@myView.grid.showView).toHaveBeenCalled()
    )

    it("should show the elements when it exists on DOM", () ->
      expect(@myView.$el.find('.table td').closest('tr').length).toBe(2)
    )
  )

  describe("Events", () ->
    describe("catching", () ->
      beforeEach ->
        @spy = jasmine.createSpyObj('spy', ['invoice_edit'])
        AppChan.reply("invoice:edit", @spy.invoice_edit)

        @myRegion = new MyRegion
        @myRegion.show(@myView)

      it("navigates to visit form", () ->
        @myView.$el.find('a[data-click="button_0"]').click()
        expect(@spy.invoice_edit).toHaveBeenCalled()
      )
    )
  )
)
