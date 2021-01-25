module.exports = {
  rules: [
    {
      test: /\.svg$/,
      use: [
        {
          loader: 'svg-url-loader',
          options: {
            stripdeclarations: false
          }
        },
        {
          loader: 'image-webpack-loader',
          options: {
            disable: true
          }
        }
      ]
    }
  ]
}
