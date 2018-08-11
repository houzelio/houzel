import AppLayout from './app/main-view'

LayoutMgr = {}

processView = (layoutName, options) ->

  if layoutName == "application"
    instance = new AppLayout

  view =
    name: layoutName
    search: options.search
    instance: instance

  view

LayoutMgr._view = {}

LayoutMgr.render = (layoutName, options) ->

  if !layoutName || !(layoutName == "application")
    throw new Error('You must provide a valid name for the layout.')

  if LayoutMgr._view.layoutName != layoutName ||
  LayoutMgr._view.search != options.search
    view = processView(layoutName, options)
    view.instance.render()

    LayoutMgr._view = view

  return

LayoutMgr.show = (regionName, view) ->

  if !@_view
    throw new Error('You must render a layout before.')

  region = LayoutMgr._view.instance.getRegion(regionName)
  region.show view

  return

export default LayoutMgr
