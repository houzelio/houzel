import HeaderView from './header-view'
import SideView from './side-view'
import template from './templates/main.pug'

export default class extends Marionette.View
  template: template
  el: 'body'

  regions:
    mainRegion: "#main-region"
    headerRegion: "#header-region"
    sideRegion: "#side-region"

  onRender: ->
    @showChildView('headerRegion', new HeaderView)
    @showChildView('sideRegion', new SideView)
