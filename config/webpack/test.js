const environment = require('./environment')
const manifestPlugin = environment.plugins.get('Manifest')

manifestPlugin.options.writeToFileEmit = process.env.NODE_ENV !== 'test'

module.exports = environment.toWebpackConfig()
