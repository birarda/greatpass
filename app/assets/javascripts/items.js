// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('turbolinks:load', function() {
  $('#_item_id').selectize();
  $('#_certification').selectize();
  $('#_paint_color').selectize();
  $('#_platform').selectize();
});
