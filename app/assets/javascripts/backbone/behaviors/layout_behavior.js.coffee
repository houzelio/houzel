import Layout from '../layouts/layout'

export default class extends Marionette.Behavior
  initialize: ->    
    Layout.render(@getOption('view'), {search: false})