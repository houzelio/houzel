module.exports = {
  rules: [
    {
      test: /\.(png|jp(e*)g|gif|svg)$/,
      use: [
        'url-loader', {
        loader: 'image-webpack-loader',
        options: {
          disable: true
        }
      }]
    }
  ]
}
