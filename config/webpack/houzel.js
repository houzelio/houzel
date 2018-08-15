const ExtractTextPlugin = require('extract-text-webpack-plugin')
const MomentLocalesPlugin = require('moment-locales-webpack-plugin');

module.exports = {
  module: {
    rules: [
      {
        test: /\.less$/,
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: [{
            loader: 'css-loader', options: {
              sourceMap: true
            }
          }, {
            loader: 'postcss-loader'
          }, {
            loader: 'less-loader', options: {
              sourceMap: true
            }
          }]
        })
      }
    ]
  },
  plugins: [
    new ExtractTextPlugin({
      filename: '[name]-[contenthash].css'
    }),

    new MomentLocalesPlugin({
      localesToKeep: ['es-us', 'pt-br']
    })
  ]
}
