export default loadInitializer = (moduleName, options = {}) ->
  config = importInitializer(moduleName)
  config.initialize()  
  return

importInitializer = (moduleName) ->
  _require = require.context('./initializers/', false, /\.js.coffee$/)
  module = "./#{moduleName}.js.coffee"  

  try    
    _require(module).Configure
  catch
    throw new Error(moduleName + ' must be a valid initializer')