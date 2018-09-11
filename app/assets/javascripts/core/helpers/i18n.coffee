import Polyglot from 'node-polyglot'

Intl = () ->
  @polyglot = {}

  return

_.extend(Intl.prototype, {
  load: (options) ->
    opts = options

    locale = opts.locale || "en"
    phrases = opts.strings.json[locale].javascripts

    @polyglot = new Polyglot({
      phrases: phrases
      locale: locale
    })

    return

  t: (key, options) ->
    polyglot = @polyglot
    if _.isEmpty(polyglot) then return

    polyglot.t(key, options)
})

_intl = new Intl()

initIntl = (options) ->
  intl = _intl.load(options)
  Object.freeze(intl)

t = (key, options) ->
  return _intl.t(key, options)

# keeps a global reference, for translations on frontend
global["t"] = t

export {
  initIntl,
  t
}
