/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

/* Images */
import '../images/logo-300.png'

/* Stylesheet */
import 'chosen-js/chosen.css';
import 'flatpickr/dist/flatpickr.css';
import 'backgrid/lib/backgrid.css';
import 'izitoast/dist/css/iziToast.css';
import 'nprogress/nprogress.css';
import '../stylesheets/less/style.less';

/* Bootstrap */
import 'bootstrap';

/* Application */
import moment from 'moment';
import logger from 'js-logger';
import numeral from 'numeral';
import 'numeral/locales';
import App from 'javascripts/core/app';

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
    numeral.locale(locale);

    const app = new App({
      phrases: strings.json[locale].javascripts, locale: locale
    });

    app.start()
  })
}
