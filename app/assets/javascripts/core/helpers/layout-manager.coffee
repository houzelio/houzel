import AppLayout from 'layouts/application/main-view'

LayoutMgr = {}

processView = (layoutName, options) ->

  if layoutName == "application"
    view = new AppLayout

  options.layoutName = layoutName
  view.mergeOptions(options, ['layoutName', 'search'])

  view

LayoutMgr.currentView = {}

LayoutMgr.render = (layoutName, options) ->

  if !layoutName || !(layoutName == "application")
    throw new Error('You must provide a valid name for the layout.')

  currView = @currentView

  if _.isEmpty(currView) ||
  currView.getOption('layoutName') != layoutName ||
  currView.getOption('search') != options.search
    layoutView = processView(layoutName, options)
    layoutView.render()

    @currentView = layoutView

  return

LayoutMgr.show = (regionName, view) ->
  currView = @currentView

  if !currView
    throw new Error('You must render a layout before.')

  currView.showChildView(regionName, view)

  return

export default LayoutMgr
