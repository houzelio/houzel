import { hasOwn, set } from './props'
import { hasSymbol } from './env'
import { isPlainObject } from './elem'

strats = {}

mergeData = (toObj, fromObj) ->
  if !fromObj
    return toObj

  toVal = fromVal = undefined

  keys = if hasSymbol then Reflect.ownKeys(fromObj)
  else Object.keys(fromObj)

  i = 0
  while i < keys.length
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

strats.created = mergeDataOrFn

defaultStrat = (parentVal, childVal) ->
  if childVal == undefined then parentVal else childVal

export mergeOptions = (parent, child) ->
  if _.isFunction(child)
    child = child.options

  if child.mixins
    for mixin in child.mixins
      parent = mergeOptions(parent, mixin)

  options = {}
  mergeField = (key) ->
    strat = strats[key] || defaultStrat
    options[key] = strat(parent[key], child[key])

  for key of parent
    mergeField key

  for key of child
    if !hasOwn(parent, key)
      mergeField key

  options
