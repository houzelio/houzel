import { AppChan } from 'channels'
import template from './templates/header.pug'

export default class extends Marionette.View
  template: template

  events:
    'click a[data-show="true"]' : () ->
      AppChan.request("user:signout")
