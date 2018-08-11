import Layout from '../layouts/layout-view'

export default class extends Marionette.Behavior
  initialize: ->
    Layout.render(@getOption('view'), {search: false})
