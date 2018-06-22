isBreakpoint = (val) ->
  width = $(window).width()
  breakpoint = 'none'

  if width < 544
    breakpoint = 'xs'
  else if width >= 544 && width < 768
    breakpoint = 'sm'
  else if width >= 768 && width < 992
    breakpoint = 'md'
  else if width >= 992 && width < 1200
    breakpoint = 'lg'
  else
    breakpoint = 'xl'

  breakpoint == val

export {
  isBreakpoint
}
