module.exports = {
  rules: [
    {
      test: require.resolve('moment'),
      use: [{
        loader: 'expose-loader',
        options: 'mom'
      }]
    }
  ]
}
