import LayoutMgr from 'javascripts/core/helpers/layout-manager'
import { showView, showViewIn } from 'javascripts/core/helpers/layout-region'

describe("Layout Region", () ->
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
    LayoutMgr.render('application')
    @myView = new MyView

  describe("::showView", () ->
    it("assumes 'mainRegion' as the one if a region is not defined", () ->
      showView(@myView)
      myChildView = LayoutMgr.currentView.getChildView('mainRegion')
      expect(@myView.cid).toBe(myChildView.cid)
    )
  )

  describe("::showViewIn", () ->
    it("shows a childView in a region of view", () ->
      myOtherView = new MyOtherView
      showViewIn(@myView, myOtherView, 'subRegion')
      myChildView = @myView.getChildView('subRegion')
      expect(myOtherView.cid).toBe(myChildView.cid)
    )
  )
)
