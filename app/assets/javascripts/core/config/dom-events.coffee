monitorDataBackbone = () ->
  $el = Dom.getEl(document)

  $el.on('click', 'a[data-backbone="true"]', (event) ->
    event.preventDefault()
    targetEl = event.currentTarget
    href = Dom.getEl(targetEl).attr('href')

    BbHst = Backbone.history

    ret = BbHst.navigate(href, true)
    if !_.isUndefined(ret) then return

    BbHst.loadUrl(BbHst.fragment)
  )

export initDomEvents = () ->
  monitorDataBackbone()
