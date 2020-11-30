import ListView from 'javascripts/core/apps/patient/list-view'
import { AppChan } from 'javascripts/core/channels'

describe("Patient List View", () ->
  MyRegion = Marionette.Region.extend({
    el: '#main-region'
  })

  beforeEach ->
    myCollection = new Backbone.Collection([
      new Backbone.Model({id: 5, name: "Elijah Hoppe", phone: "623-878-1901 x223", birthday: "1992-11-03"}),
      new Backbone.Model({id: 7, name: "Sofia Grimes", phone: "(754)560-3507 x7815", birthday: "2001-01-06"})
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
        @spy = jasmine.createSpyObj('spy', ['patient_show', 'patient_edit'])
        AppChan.reply("patient:show", @spy.patient_show)
        AppChan.reply("patient:edit", @spy.patient_edit)

        @myRegion = new MyRegion
        @myRegion.show(@myView)

      it("navigates to patient info", () ->
        @myView.$el.find('a[data-click="button_0"]').click()
        expect(@spy.patient_show).toHaveBeenCalled()
      )

      it("navigates to patient form", () ->
        @myView.$el.find('a[data-click="button_1"]').click()
        expect(@spy.patient_edit).toHaveBeenCalled()
      )
    )
  )
)
