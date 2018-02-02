const { environment } = require('@rails/webpacker')
const houzelConfig = require('./houzel')
const webpack = require('webpack')
const file = require('./loaders/file')
const eco = require('./loaders/eco')
const yaml2js = require('./loaders/yaml2js')

const babelLoader = environment.loaders.get('babel')

// Extensions
environment.config.set('resolve.extensions', ['.coffee', '.js.coffee'])

// Merge houzel config
environment.config.merge(houzelConfig)

// Loaders
environment.loaders.insert('coffee', {
  test: /\.coffee(\.erb)?$/,
  use:  babelLoader.use.concat(['coffee-loader'])
})

environment.loaders.append('file', file)
environment.loaders.append('eco', eco)
environment.loaders.append('yaml2js', yaml2js)

// Plugins
environment.plugins.append(
  'Provide',
  new webpack.ProvidePlugin({
    _: 'underscore',
    $: 'jquery',
    jQuery: 'jquery',
    jquery: 'jquery',
    Backbone: 'backbone',
    Marionette: 'backbone.marionette'
  })
)

module.exports = environment
