import LayoutMgr from 'javascripts/core/helpers/layout-manager'

describe("Layout Manager", () ->
  MyView = Marionette.View.extend({
    template: () ->
      __html__['my-view.html']
  })

  beforeEach ->
    LayoutMgr.render('application')

  describe("::render", () ->
    it("sets a layout view", () ->
      expect(LayoutMgr.currentView.cid).not.toBeUndefined()
    )

    it("should not render a new layout if the layout defined is already rendered", () ->
      oldLayout = LayoutMgr.currentView
      LayoutMgr.render('application')
      newLayout = LayoutMgr.currentView
      expect(oldLayout.cid).toBe(newLayout.cid)
    )

    it("should render a new layout if they differ", () ->
      oldLayout = LayoutMgr.currentView
      LayoutMgr.render('user')
      newLayout = LayoutMgr.currentView
      expect(oldLayout.cid).not.toBe(newLayout.cid)
    )

    it("throws an exception if a layout is invalid", () ->
      expect(() ->
        LayoutMgr.render()
      ).toThrowError("You must provide a valid name for the layout.")
    )
  )

  describe("::show", () ->
    it("shows a view in a region of the layout", () ->
      myView = new MyView
      LayoutMgr.show('mainRegion', myView)
      myChildView = LayoutMgr.currentView.getChildView('mainRegion')
      expect(myView.cid).toBe(myChildView.cid)
    )
  )
)
