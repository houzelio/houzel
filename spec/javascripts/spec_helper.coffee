import defaultLocale from "../../config/locales/javascript/en.yml"
import { initIntl } from 'javascripts/core/helpers/i18n'

import 'bootstrap'

Backbone.$ = $

window.gon = {
  user: {
    name: "Luccas Marks"
    email: "luccas@houzel.com"
    admin: false
  }
  locale: "en"
}

locale = defaultLocale.json['en'].javascripts
initIntl(phrases: locale)

requireAll = (requireContext) ->
  requireContext.keys().forEach(requireContext)

requireAll(require.context('./', true, /^((?!spec_helper).)*\.coffee?$/))
