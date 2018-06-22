import { isBreakpoint } from '../../helpers/responsive'
import template from '../templates/app-header.pug'

export default class extends Marionette.LayoutView
  template: template

  ui:
    toggleSelector: "[data-toggle-state]"

  templateHelpers: ->
    isBreakpoint: isBreakpoint
