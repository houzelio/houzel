import { new_invoice_path, invoice_index_path } from 'routes'
import { t } from 'helpers/i18n'
import Entity from './entity'

Invoice = Entity.extend({
  urlRoot: -> invoice_index_path()

  validation:
    patient_id:
      required: true
      msg: -> t('general.messages.required_field')

  create: (attrs, options) ->
    options = _.extend({}, options, {
      urlRoot: new_invoice_path(), fetch: true
    })

    Entity.prototype.create.call(@, attrs, options)

})

export default new Invoice
