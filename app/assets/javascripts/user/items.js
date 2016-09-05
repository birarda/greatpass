// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('turbolinks:load', function() {
  $('#user_item_item_id').selectize();
  $('#user_item_certification').selectize();
  $('#user_item_paint_color').selectize();

  $('.certification-select-group').hide();
  $('.paint-select-group').hide();

  // handle radio button changes
  $('input[type=radio][name=user_item\\[kind\\]]').change(function() {
    $('.certification-select-group').hide();
    $('.paint-select-group').hide();

    if (this.value == 1) {
      $('.certification-select-group').show();
    } else if (this.value == 2) {
      $('.paint-select-group').show();
    }
  });
});
