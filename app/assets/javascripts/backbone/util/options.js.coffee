import { hasOwn, set } from './props'

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
