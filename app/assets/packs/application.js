/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

/* Stylesheet */
import '../stylesheets/modules.css';
import '../stylesheets/application.less';

/* Bootstrap */
import 'bootstrap';

/* Application */
import App from '../javascripts/src/app';
import moment from 'moment';

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
