import ListView from 'javascripts/core/apps/appointment/list-view'
import { AppChan } from 'javascripts/core/channels'
import PageableCollection from "backbone.paginator"
import sinon from 'sinon'

describe("Appointment List View", () ->
  MyRegion = Marionette.Region.extend({
    el: '#main-region'
  })

  beforeEach ->
    myCollection = new PageableCollection([
      new Backbone.Model({id: 5, patient_name: "Elijah Hoppe", examiner_name: "Luccas Marks"}),
      new Backbone.Model({id: 7, patient_name: "Sofia Grimes", examiner_name: "Joseane Fogaça"})
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

  describe("::onAnchorDataToggle", () ->
    it("should update the view when filtering elements by interval", () ->
      server = sinon.fakeServer.create()

      date = mom().format('YYYY-MM-DD')
      url = new RegExp("/appointment\\?page\\=1&per_page\\=25&filter%5Bstart_date%5D\\=#{date}%2000%3A00&filter%5Bend_date%5D\\=#{date}%2023%3A59\\w*")

      server.respondWith("GET", url,
                       [
                         200,
                         { "Content-Type": "application/json" },
                         JSON.stringify({id: 7, patient_name: "Sofia Grimes", examiner_name: "Joseane Fogaça"})
                       ])

      @myRegion = new MyRegion
      @myRegion.show(@myView)

      collection = @myView.grid.getCollection()
      collection.url = "/appointment"

      @myView.$el.find('a[href="#day"]').click()
      server.respond()

      expect(@myView.$el.find('.table td').closest('tr').length).toBe(1)
      expect(@myView.$el.find('table.table')).toContainText( "Sofia Grimes")
      expect(@myView.$el.find('table.table')).not.toContainText("Elijah Hoppe")

      server.restore()
    )
  )

  describe("Events", () ->
    describe("catching", () ->
      beforeEach ->
        @spy = jasmine.createSpyObj('spy', ['visit_edit', 'appointment_edit'])
        AppChan.reply("visit:edit", @spy.visit_edit)
        AppChan.reply("appointment:edit", @spy.appointment_edit)

        @myRegion = new MyRegion
        @myRegion.show(@myView)

      it("navigates to visit form", () ->
        @myView.$el.find('a[data-click="button_0"]').click()
        expect(@spy.visit_edit).toHaveBeenCalled()
      )

      it("navigates to appointment form", () ->
        @myView.$el.find('a[data-click="button_1"]').click()
        expect(@spy.appointment_edit).toHaveBeenCalled()
      )
    )
  )
)
