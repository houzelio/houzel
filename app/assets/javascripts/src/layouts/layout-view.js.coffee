import AppLayout from './app/main-view'

Layout = {}

processView = (layoutName, options) ->

  if layoutName == "application"
    instance = new AppLayout

  view =
    name: layoutName
    search: options.search
    instance: instance

  view

Layout._view = {}

Layout.render = (layoutName, options) ->

  if !layoutName || !(layoutName == "application")
    throw new Error('You must provide a valid name for the layout.')

  if Layout._view.layoutName != layoutName ||
  Layout._view.search != options.search
    view = processView(layoutName, options)
    view.instance.render()

    Layout._view = view

  return

Layout.show = (regionName, view) ->

  if !@_view
    throw new Error('You must render a layout before.')

  region = Layout._view.instance.getRegion(regionName)
  region.show view

  return

export default Layout;
