import HeaderView from './app-header-view'
import template from '../templates/app-base.pug'

export default class extends Marionette.LayoutView
  template: template
  el: 'body'

  regions:
    mainRegion: "#main-region"
    headerRegion: "#header-region"

  onRender: ->
    @headerRegion.show new HeaderView
