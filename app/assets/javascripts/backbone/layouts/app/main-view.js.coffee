import HeaderView from './header-view'
import template from './templates/main.pug'

export default class extends Marionette.LayoutView
  template: template
  el: 'body'

  regions:
    mainRegion: "#main-region"
    headerRegion: "#header-region"

  onRender: ->
    @headerRegion.show new HeaderView
