// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('turbolinks:load', function() {
  var $selectized_selects = [$('#match_have__item_id'), $('#match_have__certification'), $('#match_have__paint_color'), $('#match_want__item_id'), $('#match_have__platform'), $('#match_want__certification'), $('#match_want__paint_color'), $('#match_want__platform')]
  $.each($selectized_selects, function(index, $select){
    $select.selectize();
  });

  $('#matchmaker-form').submit(function(e){

    if (!$('#match_have__item_id').val() || !$('#match_want__item_id').val()) {
      $('#pick-item-error').show();
      return false;
    }
  });
});


$(document).on('turbolinks:before-cache', function() {
  $('.selectized').each(function() {
    this.selectize.destroy();
  });
});
