//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require handlebars
//= require ember
//= require ember-data
//= require localstorage_adapter
//= require jquery.cookie
//= require bootstrap-datepicker
//= require_self
//= require auth

// for more details see: http://emberjs.com/guides/application/
window.Auth = Ember.Application.create({
  LOG_TRANSITIONS:          true,
  LOG_TRANSITIONS_INTERNAL: true
});

$.cookie.json = true;
