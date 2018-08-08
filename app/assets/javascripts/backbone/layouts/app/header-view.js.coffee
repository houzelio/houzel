import { isBreakpoint } from '../../helpers/responsive'
import template from './templates/header.pug'

  template: template

  ui:
    toggleSelector: "[data-toggle-state]"

    isBreakpoint: isBreakpoint

export default class extends Marionette.View
  templateContext: ->
