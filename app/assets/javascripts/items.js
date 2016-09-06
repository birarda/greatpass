// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('turbolinks:load', function() {
  $('#search__item_id').selectize();
  $('#search__certification').selectize();
  $('#search__paint_color').selectize();
  $('#search__platform').selectize();
  $('#search__kind').selectize();
});
