/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

/* Stylesheet */
import 'bootstrap';
import '../stylesheets/modules.css';
import '../stylesheets/application.less';

/* Application */
import App from '../javascripts/backbone/app';

document.addEventListener("DOMContentLoaded", function() {
  load_locale_strings();

  const app = new App();
  app.start({});
});

function load_locale_strings() {
  global.polyglot = new (require('node-polyglot'));
  const locale = gon.locale;

  import(`${process.env.LOCALE_PATH}/${locale}.yml`)
  .then(strings => {
    polyglot.extend(strings.json[locale].javascripts);
    polyglot.locale(locale);
  })
  .catch(_error => {
    throw new Error('Locale file not found.');
  });
}
