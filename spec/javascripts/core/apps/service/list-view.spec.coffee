import ListView from 'javascripts/core/apps/service/list-view'
import { AppChan } from 'javascripts/core/channels'

describe("Service List View", () ->
  MyRegion = Marionette.Region.extend({
    el: '#main-region'
  })

  beforeEach ->
    myCollection = new Backbone.Collection([
      new Backbone.Model({id: 2, name: "Check In", category: "private", value: 109.99}),
      new Backbone.Model({id: 3, name: "Exam Lab", category: "other", value: 99.99})
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
        @spy = jasmine.createSpyObj('spy', ['service_edit'])
        AppChan.reply("service:edit", @spy.service_edit)

        @myRegion = new MyRegion
        @myRegion.show(@myView)

      it("navigates to service form", () ->
        @myView.$el.find('a[data-show="true"]').click()
        expect(@spy.service_edit).toHaveBeenCalled()
      )
    )
  )
)
