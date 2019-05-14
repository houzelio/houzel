import Component from 'javascripts/api/component'
import Backgrid from 'backgrid'
import { t } from 'helpers/i18n'
import 'backgrid-paginator'

Dom = Marionette.DomApi

ClassOptions = [
  'windowSize'
]

ViewOptions = [
  'columns',
  'collection',
  'className',
  'emptyText',
  'footer'
]

defaults = {
  editable: false
  sortable: false
}

# Allows the vanilla 'Backgrid.Grid' to support Marionette
GridView = Backgrid.Grid.extend()
_.extend(GridView.prototype, Marionette.Events)

# When a render is not defined, we need to pass a
# function that renders the cell.
defaultRender = () ->
  $el = @$el
  model = @model
  columnName = @column.get("name");
  data = @formatter.fromRaw(model.get(columnName), model)

  template = @template
  if _.isFunction(template)
    data = template(data)

  $el.html(data)
  @updateStateClassesMaybe()
  @delegateEvents()
  $el.trigger('el:rendered')
  @

export default Component.extend({
  windowSize: 10

  viewOptions:
    className: "table grid table-hover"

  viewClass: GridView

  initialize: (options) ->
    @mergeOptions(options, ClassOptions)
    @mergeIntoOption('viewOptions', options, ViewOptions)

    @_normalizeColumns(options)
    @_initCollection()

    el = @getOption('el')
    @el = if el instanceof $ then el[0] else el

    return

  showView: () ->
    $el = Dom.getEl(@el)

    region = new Marionette.Region(el: $el)
    @showViewIn(null, region)
    @_showPaginator($el)

    return

  _showPaginator: (parentEl) ->
    allowPagination = @getOption('allowPagination')
    if !_.isUndefined(allowPagination) && !allowPagination then return

    collection = @getCollection()
    totalRecords = _.result(collection.state, 'totalRecords', -1)
    if !(totalRecords > @windowSize) then return

    $el = @_paginatorEl(parentEl)

    @showPaginator($el)

    return

  showPaginator: ($el) ->
    collection = @getCollection()
    paginatorOptions = _.extend({}, _.pick(@, 'windowsSize'), collection)

    paginatorView = new Paginator(paginatorOptions)
    region = new Marionette.Region({el: $el})
    region.show(paginatorView)

    @regionPaginator = region

    return

  _paginatorEl: (parentEl) ->
    className = _.result(@options, 'classPaginator', 'pagination-container')
    el = '<div class="' + className + '"></div>'
    $el = $(el)

    parentEl.after($el)
    $el

  _normalizeColumns: (options) ->
    columns = options.columns
    if !columns then return

    _.each(columns, (column) =>
      @_normalizeColumn(column)
    )

    return

  _normalizeColumn: (column) ->
    formatter = column.formatter
    if _.isFunction(formatter)
      column.formatter = _.extend({}, Backgrid.CellFormatter.prototype, {
        fromRaw: formatter
      })

    thClassName = column.thClassName
    if _.isString(thClassName)
      column.headerCell = Backgrid.HeaderCell.extend({
        className: thClassName
      })

    cell = column.cell
    if _.has(cell, "extend")
      column.cell = @_extendCell(cell)

    _.defaults(column, defaults)

    return

  _extendCell: (cell) ->
    props = _.result(cell, 'extend')
    props = _.defaults(props, render: defaultRender)

    _cell = Backgrid.Cell.extend(props)
    _cell

  addElement: (model) ->
    collection = @getCollection()
    collection.add(model)

  removeElement: (model) ->
    collection = @getCollection()
    collection.remove(model)

  _initCollection: () ->
    collection = @getOption('collection')

    if !(collection instanceof Backbone.Collection)
      @viewOptions.collection = new Backbone.Collection(collection)

    @_collectionEvents()

    return

  getCollection: () ->
    @getOption('collection', 'viewOptions')

  _collectionEvents: () ->
    collection = @getOption('collection', 'viewOptions')
    ['add', 'remove', 'change'].forEach (event) =>
      @listenTo(collection, event, (model) =>
        @triggerMethod('grid:' + event, model, collection)
      )

    return

  _destroyView: () ->
    region = @regionPaginator
    if region
      region.empty()

    Component.prototype._destroyView.call(@)

    return

  _removeReferences: () ->
    Component.prototype._removeReferences.call(@)
    delete @regionPaginator

    return
})

Paginator = Backgrid.Extension.Paginator.extend({
  className: 'paginator'

  initialize: (options) ->
    ctrls = @controls
    ctrls.rewind.title = t('general.pagination.rewind.title')
    ctrls.back.title = t('general.pagination.back.title')
    ctrls.forward.title = t('general.pagination.forward.title')
    ctrls.fastForward.title = t('general.pagination.fastForward.title')

    @parentEl = options.parentEl
    Paginator.__super__.initialize.apply(@, arguments)

    return

  render: () ->
    Paginator.__super__.render.apply(@, arguments)
    @$el.find('ul').addClass('pagination pagination-sm')

    @
})

# Allows Paginator to support Marionette
_.extend(Paginator.prototype, Marionette.Events)
