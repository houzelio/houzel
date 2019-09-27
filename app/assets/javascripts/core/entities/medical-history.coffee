import Routes from 'helpers/routes'
import Entity from './entity'

MclHistory = Entity.extend({
  urlRoot: -> Routes.medical_history_index_path()
})

export default new MclHistory
