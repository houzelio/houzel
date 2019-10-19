import DialogCmp from 'components/box-dialog'
import SelectCmp from 'components/select'
import PickerCmp from 'components/datepicker'
import ValidationMixin from 'mixins/validation'
import template from './templates/form.pug'

export default class extends Marionette.View
  template: template
  tagName: "div"

  mixins: [ValidationMixin]

  bindings:
    '#name-in' : 'name'

  triggers:
    'click #save-btn': 'profile:general:save'

  onAttach: () ->
    @_showSelects()
    @_showPickers()

  _showSelects: () ->
    new SelectCmp({
      el: '#language-sel',
      disable_search: true,
      value: gon.locale
    })

    return

  _showPickers: () ->
    #birthday picker
    picker = new PickerCmp({
      el: '#birth-pickr',
      wrap: true
    })

    @listenTo(picker, 'picker:update', ->
      @model.set('birthday', $('#birth-in').val())
    )

    return

  showInfo: (callback) ->
    dialog = new DialogCmp({
      size: "small"
      closeButton: false
    })

    @listenTo(dialog, 'dialog:action:result', => callback() )

    dialog.alert(t('profile.messages.refresh_profile'))
