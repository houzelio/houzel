module.exports = {
  rules: [
    {
      test: require.resolve('backbone'),
      use: "imports-loader?define=>false"
    }
  ]
}
