import HeaderView from './header-view'
import template from './templates/main.pug'

export default class extends Marionette.View
  template: template
  el: 'body'

  regions:
    mainRegion: "#main-region"
    headerRegion: "#header-region"

  onRender: () ->
    @_addBdyClass()

    @showChildView('headerRegion', new HeaderView)

  _addBdyClass: () ->
    $el = $('body')
    $el.addClass('bdy')

    return
