import { AppChan } from 'channels'
import logo from 'images/logo-mirage.svg'
import template from './templates/header.pug'

export default class extends Marionette.View
  template: template

  templateContext: ->
    logo: logo

  events:
    'click #logout' : () ->
      AppChan.request("user:signout")
