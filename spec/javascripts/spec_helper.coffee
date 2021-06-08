import defaultLocale from "../../config/locales/javascript/en.yml"
import { t } from 'javascripts/core/helpers/i18n'

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

phrases = defaultLocale.json['en'].javascripts
t().load(phrases: phrases)

requireAll = (requireContext) ->
  requireContext.keys().forEach(requireContext)

requireAll(require.context('./', true, /^((?!spec_helper).)*\.coffee?$/))
