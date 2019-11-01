import LayoutMgr from './layout-manager'

defaultRegion = 'mainRegion'

# Shows the view on the default region
showView = (view, region) ->
  LayoutMgr.show((if region then region else defaultRegion), view)

showViewIn = (view, childView, childRegion, region) ->
  showView(view, region)

  view.showChildView(childRegion, childView)

export {
  showView,
  showViewIn
}
