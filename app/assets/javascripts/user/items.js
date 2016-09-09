// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('turbolinks:load', function() {
  var $selects = [$('#user_item_item_id'), $('#user_item_certification'), $('#user_item_paint_color')];

  $.each($selects, function(index, $select){
    $select.selectize();
  });

  $('#user_item_certified').change(function(){
    $('.certification-select-group').toggle($(this).prop('checked'));
  });
  $('#user_item_painted').change(function(){
    $('.paint-select-group').toggle($(this).prop('checked'));
  });

  $('.certification-select-group').toggle($('#user_item_certified').prop('checked'));
  $('.paint-select-group').toggle($('#user_item_painted').prop('checked'));

});

$(document).on('turbolinks:before-cache', function() {
  $('.selectized').each(function() {
    this.selectize.destroy();
  });
});
