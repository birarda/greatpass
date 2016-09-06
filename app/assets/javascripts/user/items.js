// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('turbolinks:load', function() {
  var $selects = [$('#user_item_item_id'), $('#user_item_certification'), $('#user_item_paint_color')];

  $.each($selects, function(index, $select){
    $select.selectize();
  });

  var kind_radio_selector = 'input[type=radio][name=user_item\\[kind\\]]'

  function handleRadioButtonState(value) {
    $('.certification-select-group').hide();
    $('.paint-select-group').hide();

    if (value == 1) {
      $('.certification-select-group').show();
    } else if (value == 2) {
      $('.paint-select-group').show();
    }
  }

  handleRadioButtonState($(kind_radio_selector + ':checked').val());

  // handle radio button changes
  $(kind_radio_selector).change(function() {
    handleRadioButtonState(this.value);
  });

});

$(document).on('turbolinks:before-cache', function() {
  $('.selectized').each(function() {
    this.selectize.destroy();
  });
});
