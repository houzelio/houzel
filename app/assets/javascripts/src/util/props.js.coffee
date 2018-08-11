import { isValidArrayIndex } from './elem'

set = (target, key, val) ->
  if(_.isArray(target) && isValidArrayIndex(key))
    target.length = Math.max(target.length, key)
    target.splice(key, 1, val)
  else if !(key of Object.prototype)
    target[key] = val

  return val

getPrototypeOf = (obj) ->
  Object.getPrototypeOf(obj)

setPrototypeOf = (obj, prototype) ->
  Object.setPrototypeOf =  Object.setPrototypeOf || (obj, prototype) ->
    obj.__proto__ = proto
    obj

  Object.setPrototypeOf(obj, prototype)

hasOwn = (obj, key) ->
  hasOwnProperty = Object::hasOwnProperty
  hasOwnProperty.call obj, key

export {
  set,
  getPrototypeOf,
  setPrototypeOf,
  hasOwn
}
