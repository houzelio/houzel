import numeral from 'numeral'

formatCurr = (val) ->
  numeral(val).format('0,0.00')

rawValue = (val) ->
  numeral(val).value()

add = (lval, rval) ->
  numeral(lval).add(rawValue(rval)).value()

export {
  formatCurr,
  rawValue,
  add
}
