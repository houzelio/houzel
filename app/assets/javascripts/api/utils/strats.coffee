import { hasOwn, set } from './props'
import { hasSymbol } from './env'
import { isPlainObject } from './elem'

import {
  EVENTS_HASH,
  FUNCTIONS_CALLBACKS
} from 'javascripts/shared/constants'

strats = {}

mergeData = (toObj, fromObj) ->
  if !fromObj
    return toObj

  toVal = fromVal = undefined

  keys = if hasSymbol then Reflect.ownKeys(fromObj)
  else _.keys(fromObj)

  l = keys.length
  i = 0
  while i < l
    key = keys[i]

    toVal = toObj[key]
    fromVal = fromObj[key]

    if !hasOwn(toObj, key)
      set(toObj, key, fromVal)
    else if toVal != fromVal &&
    isPlainObject(toVal) &&
    isPlainObject(fromVal)

      mergeData(toVal, fromVal)

    i++

  toObj

mergeDataOrFn = (parentVal, childVal) ->
  if !childVal
    parentVal

  if !parentVal
    childVal

  return mergedDataFn = ->
    mergeData(
      if _.isFunction(childVal) then childVal.call(this, this) else childVal,
      if _.isFunction(parentVal) then parentVal.call(this, this) else parentVal
    )

FUNCTIONS_CALLBACKS.forEach (fn) =>
  strats[fn] = mergeDataOrFn

#
# Object hashes.
#
mergeObjHash = (parentVal, childVal) ->
  if !parentVal then return childVal

  ret = _.extend({}, parentVal, childVal)
  return ret

EVENTS_HASH.forEach (obj) =>
  strats[obj] = mergeObjHash

defaultStrat = (parentVal, childVal) ->
  if childVal == undefined then parentVal else childVal

#
# Merge source object into destination object
# according to strats.
#
export mergeStrats = (parent, child, keysFunc) ->
  if !keysFunc then keysFunc = _.allKeys

  if child.mixins
    for mixin in child.mixins
      parent = mergeStrats(parent, mixin, keysFunc)

  mergeField = (key) ->
    strat = strats[key] || defaultStrat
    parent[key] = strat(parent[key], child[key])

  keys = keysFunc(child)
  l = keys.length
  i = 0
  while i < l
    mergeField keys[i]
    i++

  parent
