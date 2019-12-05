const puppeteer = require('puppeteer');
const webpackConfig = require('./config/webpack/test.js')

process.env.CHROME_BIN = puppeteer.executablePath();

module.exports = function(config) {
  config.set({
    basePath: '',
    frameworks: ['jasmine', 'jasmine-jquery', 'jasmine-matchers'],
    plugins: [
      'karma-jasmine',
      'karma-webpack',
      'karma-chrome-launcher',
      '@metahub/karma-jasmine-jquery',
      'karma-jasmine-matchers',
      'karma-html2js-preprocessor'
    ],
    files: [
      'spec/javascripts/spec_helper.coffee',
      'spec/javascripts/fixtures/*.html'
    ],
    exclude: [
    ],
    webpack: webpackConfig,
    preprocessors: {
      'spec/javascripts/spec_helper.coffee' : ['webpack'],
      '**/*.html': ['html2js']
    },
    mime: { "text/x-coffeescript": ["coffee"] },
    reporters: ['progress'],
    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    autoWatch: false,
    browsers: ['Chrome'],
    singleRun: false,
    concurrency: Infinity,
    html2JsPreprocessor: {
      stripPrefix: 'spec/javascripts/fixtures/'
    }
  })
}
