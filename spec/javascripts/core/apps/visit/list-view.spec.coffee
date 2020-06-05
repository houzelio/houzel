import ListView from 'javascripts/core/apps/visit/list-view'
import { AppChan } from 'javascripts/core/channels'

describe("Visit List View", () ->
  MyRegion = Marionette.Region.extend({
    el: '#main-region'
  })

  beforeEach ->
    myCollection = new Backbone.Collection([
      new Backbone.Model({id: 1, patient_name: "Elijah Hoppe", sex: "female", start_date_long: "2019-05-22 13:35:42"}),
      new Backbone.Model({id: 2, patient_name: "Sofia Grimes", sex: "female", start_date_long: "2018-03-04 09:32:08"})
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
      expect(@myView.$el.find('.content-btn').children().length).toBe(1)
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
        @spy = jasmine.createSpyObj('spy', ['visit_edit'])
        AppChan.reply("visit:edit", @spy.visit_edit)

        @myRegion = new MyRegion
        @myRegion.show(@myView)

      it("navigates to visit form", () ->
        @myView.$el.find('a[data-show="true"]').click()
        expect(@spy.visit_edit).toHaveBeenCalled()
      )
    )
  )
)
