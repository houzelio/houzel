import Polyglot from 'node-polyglot'

Intl =
  polyglot: {}

  load: (phrases, locale) ->
    @polyglot = new Polyglot({
      locale: locale || "en"
      phrases: phrases
    })

    return

  t: (key, options) ->
    polyglot = @polyglot
    if _.isEmpty(@polyglot) then return

    polyglot.t(key, options)

initIntl = (options) ->
  Intl.load(options.phrases, options.locale)
  Intl

t = (key, options) ->
  return Intl.t(key, options)

export {
  initIntl,
  t
}

# keeps a global reference, for translations on frontend
global["t"] = t
