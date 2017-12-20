const { environment } = require('@rails/webpacker')
const houzelConfig = require('./houzel')
const webpack = require('webpack')
const coffee = require('./loaders/coffee')
const file = require('./loaders/file')
const eco = require('./loaders/eco')

// Merge houzel config
environment.config.merge(houzelConfig)

// Loaders
environment.loaders.append('coffee', coffee)
environment.loaders.append('file', file)
environment.loaders.append('eco', eco)

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
