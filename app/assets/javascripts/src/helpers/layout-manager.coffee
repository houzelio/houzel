import AppLayout from 'layouts/application/main-view'

LayoutMgr = {}

processView = (layoutName, options) ->

  if layoutName == "application"
    view = new AppLayout

  options.layoutName = layoutName
  view.mergeOptions(options, ['layoutName', 'search'])

  view

LayoutMgr._view = {}

LayoutMgr.render = (layoutName, options) ->

  if !layoutName || !(layoutName == "application")
    throw new Error('You must provide a valid name for the layout.')

  if _.isEmpty(@view) ||
  @_view.getOption('layoutName') != layoutName ||
  @_view.getOption('search') != options.search
    view = processView(layoutName, options)
    view.render()

    @_view = view

  return

LayoutMgr.show = (regionName, view) ->

  if !@_view
    throw new Error('You must render a layout before.')

  region = @_view.getRegion(regionName)
  region.show view

  return

export default LayoutMgr
