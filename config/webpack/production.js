process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environment')

environment.devtool = 'hidden-source-map'

module.exports = environment.toWebpackConfig()
