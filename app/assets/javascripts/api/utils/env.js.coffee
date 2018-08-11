isNative = (Ctor) ->
  _.isFunction(Ctor) && /native code/.test(Ctor.toString())

hasSymbol =
  typeof Symbol != undefined && isNative(Symbol) &&
  typeof Reflect != undefined && isNative(Reflect.ownKeys)

export {
  isNative,
  hasSymbol
}
