import { AppChan } from 'channels'
import {  hzEllipsisHSolid } from 'houzel-icons/svg-icons'
import logo from 'images/logo-mirage.svg'
import template from './templates/header.pug'

export default class extends Marionette.View
  template: template

  templateContext: ->
    logo: logo
    icons:
      ellipsis: hzEllipsisHSolid
  events:
    'click #logout' : () ->
      AppChan.request("user:signout")
