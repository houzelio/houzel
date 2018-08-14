import LayoutMgr from 'helpers/layout-manager'

export default class extends Marionette.Behavior
  initialize: ->
    LayoutMgr.render(@getOption('view'), {search: false})
