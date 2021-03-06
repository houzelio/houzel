import { hzCalendarDaySolid } from 'houzel-icons/svg-icons'
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

  templateContext: =>
    icons:
      calendar_day: hzCalendarDaySolid

  onAttach: () ->
    @_showSelects()
    @_showPickers()

  _showSelects: () ->
    @selects = {}

    @selects['#language-sel'] = new SelectCmp({
      el: '#language-sel',
      disable_search: true,
      value: gon.locale
    })

    return

  _showPickers: () ->
    @pickers = {}

    #birthday picker
    @pickers['#birth-pickr'] = new PickerCmp({
      el: '#birth-pickr',
      wrap: true
    })

    @listenTo(@pickers['#birth-pickr'], 'picker:update', ->
      @model.set('birthday', Dom.getEl('#birth-in').val())
    )

    return

  showInfo: (callback) ->
    dialog = new DialogCmp({
      size: "small"
      closeButton: false
    })

    @listenTo(dialog, 'dialog:action:result', => callback() )

    dialog.alert(t('profile.messages.refresh_profile'))

  onBeforeDestroy: () ->
    @pickers['#birth-pickr'].destroy()
