import Polyglot from 'node-polyglot'

Intl =

  load: (phrases, locale) ->
    @polyglot = new Polyglot({
      locale: locale || "en"
      phrases: phrases
    })

    return

  parse: (key, options) ->
    if _.isUndefined(@polyglot) then return

    @polyglot.t(key, options)

initIntl = (options) ->
  Intl.load(options.phrases, options.locale)
  Intl

t = (key, options) ->
  if _.every(arguments, _.isUndefined) then return Intl

  Intl.parse(key, options)

export {
  initIntl,
  t
}

# keeps a global reference, for translations on frontend
global["t"] = t
