/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

/* Stylesheet */
import 'chosen-js/chosen.min.css';
import 'backgrid/lib/backgrid.min.css';
import '../stylesheets/less/style.less';

/* Bootstrap */
import 'bootstrap';

/* Application */
import moment from 'moment';
import logger from 'js-logger';
import App from '../javascripts/src/app';

/* Logger */
logger.useDefaults({
  formatter: function (messages) {
    messages.unshift(new Date().toISOString())
  }
});

document.addEventListener("DOMContentLoaded", function() {
  setupStartApp();
});

function setupStartApp() {
  const locale = gon.locale;

  import(`${process.env.LOCALE_PATH}/${locale}.yml`)
  .then(strings => {
    moment.locale(locale);

    const app = new App({
      strings: strings, locale: locale
    });

    app.start()
  })
}
