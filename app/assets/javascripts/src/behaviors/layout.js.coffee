import LayoutMgr from 'layouts/layout-manager'

export default class extends Marionette.Behavior
  initialize: ->
    LayoutMgr.render(@getOption('view'), {search: false})
