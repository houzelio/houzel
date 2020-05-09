import { medical_history_index_path } from 'routes'
import Entity from './entity'

MclHistory = Entity.extend({
  urlRoot: -> medical_history_index_path()
})

export default new MclHistory
