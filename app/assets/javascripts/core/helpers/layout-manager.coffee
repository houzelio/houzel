import AppLayout from 'layouts/application/main-view'
import UserLayout from 'layouts/user/main-view'

LayoutMgr = {}

layouts = ['application', 'user']

getLayoutView = (layoutName, options) ->
  if layoutName == "application"
    view = new AppLayout
  else if layoutName == "user"
    view = new UserLayout
  else
    throw new Error("Invalid layout.")

  view.layoutName = layoutName
  view

LayoutMgr =
  render: (layoutName, options) ->

    if !layoutName || !(_.contains(layouts, layoutName))
      throw new Error('You must provide a valid name for the layout.')

    currView = @currentView

    if _.isUndefined(currView) ||
    currView.getOption('layoutName') != layoutName
      layoutView = getLayoutView(layoutName, options)
      layoutView.render()

      @currentView = layoutView

    @

  show: (regionName, view) ->
    currView = @currentView

    if !currView
      throw new Error('You must render a layout before.')

    currView.showChildView(regionName, view)

    view


