import { renderLayout } from 'helpers/layout-manager'

export default class extends Marionette.Behavior
  initialize: ->
    renderLayout(@getOption('view'), {search: false})
