import {
  new_patient_path,
  patient_index_path,
  new_appointment_path,
  appointment_index_path,
  new_visit_path,
  visit_index_path,
  new_invoice_path,
  invoice_index_path,
  new_service_path,
  service_index_path
} from 'routes'

import {
  hzBookMedicalSolid,
  hzCalendarAlt
  hzChevronRightSolid,
  hzMoneyCheckSolid,
  hzPlusSolid,
  hzUsersSolid
} from 'houzel-icons/svg-icons'

import pluralize from 'pluralize'
import template from './templates/side.pug'

export default class extends Marionette.View
  template: template

  tagName: 'nav'
  className: 'sidebar'

  events:
    'click li' : 'onListItemClick'

  templateContext:
    icons:
      book_medical: hzBookMedicalSolid
      calendar: hzCalendarAlt
      chevron_ritght: hzChevronRightSolid
      money: hzMoneyCheckSolid
      plus: hzPlusSolid
      users: hzUsersSolid
    route: (name) ->
      path = switch name
        when "new_patient" then new_patient_path()
        when "patients" then patient_index_path()
        when "new_appointment" then new_appointment_path()
        when "appointments" then appointment_index_path()
        when "new_visit" then new_visit_path()
        when "visits" then visit_index_path()
        when "new_invoice" then new_invoice_path()
        when "invoices" then invoice_index_path()
        when "new_service" then new_service_path()
        when "services" then service_index_path()

      path

  onListItemClick: (event) ->
    event.preventDefault()
    $el = Dom.getEl(event.currentTarget)

    targetItem = $el.data('target-item')
    if _.isUndefined(targetItem) then return

    $currentEl = Dom.getEl('.group-active')
    if !_.isEqual($el.get(0), $currentEl.get(0))
      $currentEl.next().collapse('hide')

      $currentEl.removeClass('group-active')
      $el.addClass('group-active')

    Dom.getEl("##{targetItem}").children('a').click()
