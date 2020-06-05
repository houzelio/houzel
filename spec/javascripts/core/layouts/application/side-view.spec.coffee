import SideView from 'javascripts/core/layouts/application/side-view'

describe("Application Side View", () ->
  MyRegion = Marionette.Region.extend({
    el: '#side-region'
  })

  beforeEach ->
    setFixtures(__html__['side-region.html'])
    @myView = new SideView

  describe("after initializing", () ->
    it("should exist", () ->
      expect(@myView).toBeTruthy()
    )
  )

  describe('::onListItemClick', () ->
    it("should target to where it's pointing", () ->
      myRegion = new MyRegion
      myRegion.show(@myView)

      spy = jasmine.createSpy('spy')

      @myView.$el.find('#11').children('a').on('click', spy)
      @myView.$el.find('li[data-target-item="11"]').click()
      expect(spy).toHaveBeenCalled()
    )
  )

)
