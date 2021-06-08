import Polyglot from 'node-polyglot'

Intl =
  load: (options) ->
    opts = options

    @polyglot = new Polyglot({
      locale: opts.locale || "en"
      phrases: opts.phrases || {}
    })

    return

  parse: (key, options) ->
    if _.isUndefined(@polyglot) then return

    @polyglot.t(key, options)

t = (key, options) ->
  if _.every(arguments, _.isUndefined) then return Intl

  Intl.parse(key, options)

export {
  t
}

# keeps a global reference, for translations on frontend
global["t"] = t
