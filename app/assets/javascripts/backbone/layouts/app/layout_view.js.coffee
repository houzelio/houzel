template = require('../templates/layout_app_view.jst.eco')

export default class extends Marionette.LayoutView
  template: template
  el: 'body'

  regions:
    mainRegion: "#main-region"