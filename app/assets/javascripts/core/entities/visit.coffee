import Routes from 'helpers/routes'
import { t } from 'helpers/i18n'
import Entity from './entity'

Visit = Entity.extend({
  urlRoot: -> Routes.visit_index_path()

  validation:
    patient_id:
      required: true
      msg: -> t('general.messages.required_field')

  create: (attrs, options) ->
    options = _.extend({}, options, {
      urlRoot: Routes.new_visit_path(), fetch: true
    })

    Entity.prototype.create.call(@, attrs, options)

})

export default new Visit
