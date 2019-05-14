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
import 'flatpickr/dist/flatpickr.css';
import 'backgrid/lib/backgrid.min.css';
import 'izitoast/dist/css/iziToast.min.css'
import 'line-awesome2/dist/css/line-awesome.css';
import '../stylesheets/less/style.less';


/* Bootstrap */
import 'bootstrap';

/* Application */
import { library, config, dom } from '@fortawesome/fontawesome-svg-core';
import { fas } from '@fortawesome/free-solid-svg-icons';
import { far } from '@fortawesome/free-regular-svg-icons';
import moment from 'moment';
import logger from 'js-logger';
import numeral from 'numeral';
import 'numeral/locales';
import App from 'javascripts/core/app';

/* fontaewsome */
library.add(fas, far);
config.keepOriginalSource = false;
dom.watch();

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
      strings: strings, locale: locale
    });

    app.start()
  })
}
