import { renderLayout, showView, showViewIn } from 'javascripts/core/helpers/layout-manager'

describe("Layout Manager", () ->
  MyView = Marionette.View.extend({
    regions:
      subRegion: '.sub-region'

    template: () ->
      """#{__html__['my-view.html']} <div class="sub-region">"""
  })

  MyOtherView = Marionette.View.extend({
    template: () ->
      __html__['my-other-view.html']
  })

  beforeEach ->
    @layout = renderLayout('application')

  describe("::renderLayout", () ->
    it("returns a Layout object", () ->
      expect(@layout).toEqual(jasmine.any(Object))
      expect(@layout).not.toEqual(null)
    )

    it("sets a layout view", () ->
      expect(@layout.currentView.cid).not.toBeUndefined()
    )

    it("should not render a new layout if the layout defined is already rendered", () ->
      oldLayoutView = @layout.currentView
      layout = renderLayout('application')
      newLayoutView = layout.currentView
      expect(oldLayoutView.cid).toBe(newLayoutView.cid)
    )

    it("should render a new layout if they differ", () ->
      oldLayoutView = @layout.currentView
      layout = renderLayout('user')
      newLayoutView = layout.currentView
      expect(oldLayoutView.cid).not.toBe(newLayoutView.cid)
    )

    it("throws an exception if a layout is invalid", () ->
      expect(() ->
        renderLayout()
      ).toThrowError("You must provide a valid name for the layout.")
    )
  )

  describe("::showView", () ->
    beforeEach ->
      @myView = new MyView

    it("shows a view in a region of the layout", () ->
      showView(@myView, 'mainRegion')
      myShownView = @layout.currentView.getChildView('mainRegion')
      expect(@myView.cid).toBe(myShownView.cid)
    )

    it("assumes 'mainRegion' as the one if a region is not defined", () ->
      showView(@myView)
      myShownView = @layout.currentView.getChildView('mainRegion')
      expect(@myView.cid).toBe(myShownView.cid)
    )
  )

  describe("::showViewIn", () ->
    it("shows a childView in a region of view", () ->
      myView = new MyView
      myOtherView = new MyOtherView
      showViewIn(myView, myOtherView, 'subRegion')
      myShownView = myView.getChildView('subRegion')
      expect(myOtherView.cid).toBe(myShownView.cid)
    )
  )
)
