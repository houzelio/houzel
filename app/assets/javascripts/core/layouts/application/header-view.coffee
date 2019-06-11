import { isBreakpoint } from 'helpers/responsive'
import template from './templates/header.pug'

export default class extends Marionette.View
  template: template

  ui:
    toggleSelector: "[data-toggle-state]"

  templateContext: ->
    isBreakpoint: isBreakpoint
