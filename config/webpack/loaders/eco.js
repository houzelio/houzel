const path = require('path')

module.exports = {
  rules: [
    {
      test: /\.eco$/,
      use: [
        {
          loader: './config/webpack/loaders/eco/loader.js'
        }
      ]
    }
  ]
}
