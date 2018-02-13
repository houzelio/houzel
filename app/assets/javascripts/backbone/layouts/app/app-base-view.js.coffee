template = require('../templates/app-base.jst.eco')

export default class extends Marionette.LayoutView
  template: template
  el: 'body'

  regions:
    mainRegion: "#main-region"
