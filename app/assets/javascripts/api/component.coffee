ClassOptions = [
  'viewOptions',
  'viewClass',
  'viewEvents'
]

# Component Methods
# -----------------
Component = Marionette.MnObject.extend({
  cidPrefix: 'mnc'

  constructor: (options) ->
    Marionette.MnObject.prototype.constructor.apply(@, arguments)
    @mergeOptions(options, ClassOptions)

    @_initView()

    return

  viewClass: Marionette.View

  _isViewShown: false

  isViewRendered: () ->
    !!@_isViewShown

  _initView: () ->
    view = @_getView()
    if !view then return

    @view = view
    @_delegateViewEvents()

    return

  showViewIn: (parent, region) ->
    if @_isViewShown
      throw new Error('A region has already shown the view.')

    region = @_getRegion(parent, region)
    if !region
      throw new Error('You must provide a valid region.')

    @triggerMethod('before:show')
    @_showView(region)
    @triggerMethod('show')

    @region = region

    return

  _getView: () ->
    if @view then return @view

    ViewClass = @viewClass
    if !ViewClass then return

    viewOptions = @_getViewOptions()
    new ViewClass(viewOptions)

  _getViewOptions: () ->
    viewOptions = @viewOptions

    if !viewOptions then return {}

    if _.isFunction(viewOptions)
      return template: viewOptions

    if _.isObject(viewOptions)
      return viewOptions

    template = -> return viewOptions
    { template }

  _getRegion: (parent, region) =>
    if region instanceof Marionette.Region
      return region

    if !parent then return

    _region = parent.getRegion(region)
    _region

  _showView: (region) ->
    view = @view
    if !view
      throw new Error('You must define or pass a view to show.')

    @listenTo(view, 'show', _.partial(@triggerMethod, 'show:view'))
    region.show(view)
    @listenTo(region, 'empty', @destroy)

    @_isViewShown = true

    return

  mergeIntoOption: (classOption, options, keys) ->
    option = _.result(@, classOption, {})
    func =_.bind(@mergeOptions, option, options, keys)
    func()

    if !_.isEmpty(option)
      @[classOption] = option

    return

  destroy: (options) ->
    if @_isDestroyed then return

    @triggerMethod('before:destroy', @, options)

    @_destroyView()
    @_removeReferences()
    @_isDestroyed = true

    @triggerMethod('destroy', @, options)
    @stopListening()

    @

  _destroyView: () ->
    region = @region

    if region && @view
      @stopListening(region)
      region.empty()

    return

  _delegateViewEvents: () ->
    _viewEvents = _.result(@, 'viewEvents')
    if @view && _viewEvents
      @bindEvents(@view, _viewEvents)
      @_viewEvents = _viewEvents

    return

  _removeReferences: () ->
    delete @_viewEvents
    delete @view
    delete @region

})

export default Component
