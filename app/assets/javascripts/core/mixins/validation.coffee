import Validation from 'backbone-validation'
import 'backbone.stickit'

export default ValidationMixin = {
  modelEvents:
    'validated': (isValid, model, errors) ->
      @showErrors(errors)

  showErrors: (errors) ->
    @_emptyDomErrors()
    if !errors then return

    bindings = @bindings
    _.chain(errors).keys().each( (attr) =>
      obj = _.chain(bindings).keys().find( (selector) =>
        _attr  = bindings[selector]
        _attr = _.result(_attr, 'observe', _attr)

        _attr == attr
      )

      _selector = obj.value()
      if _selector then @_showError(_selector, errors[attr])
    )

    return

  _showError: (selector, message) ->
    message = if _.isArray(message) then _.first(message) else message

    $el = @_getParentEl(selector, '.form-group')
    $el.addClass('has-error')
    $el.find('.help-block').text(message)

    return

  onRender: () ->
    @_bind()

  _bind: () ->
    Validation.bind(@)
    @stickit()

  _getParentEl: (selector, parentSel) =>
    $el = $(selector).closest(parentSel)

  _emptyDomErrors: () =>
    $('.form-group').removeClass('has-error')
    $('.help-block').text('')

    return
}
