_toString = Object.prototype.toString

isPlainObject = (obj) ->
  _toString.call(obj) == '[object Object]'

isValidArrayIndex = (val) =>
  n = parseFloat(String(val))
  n >= 0 && Math.floor(n) == n && isFinite(val)

export {
  isPlainObject,
  isValidArrayIndex
}
