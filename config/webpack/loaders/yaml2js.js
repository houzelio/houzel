module.exports = {
  rules: [
    {
      test: /\.yml$/,
      use: [
        {
          loader: './config/webpack/loaders/yaml2js/index.js'
        }
      ]
    }
  ]
}