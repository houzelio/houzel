import Routes from 'helpers/routes'
import { t } from 'helpers/i18n'
import Entity from './entity'

Invoice = Entity.extend({
  urlRoot: -> Routes.invoice_index_path()

  validation:
    patient_id:
      required: true
      msg: -> t('general.messages.required_field')

  create: (attrs, options) ->
    options = _.extend({}, options, {
      urlRoot: Routes.new_invoice_path(), fetch: true
    })

    Entity.prototype.create.call(@, attrs, options)

})

export default new Invoice
