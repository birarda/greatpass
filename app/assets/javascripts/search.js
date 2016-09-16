// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('turbolinks:load', function() {
  var $selectized_selects = [$('#search__item_id'), $('#search__certification'), $('#search__paint_color'), $('#search__rare_class'), $('#search__platform'), $('#search__kind')]
  $.each($selectized_selects, function(index, $select){
    $select.selectize({
      closeAfterSelect: true,
      onDropdownClose: function(dropdown) {
        $(dropdown).prev().find('input').blur();
      }
    });
  });
});


$(document).on('turbolinks:before-cache', function() {
  $('.selectized').each(function() {
    this.selectize.destroy();
  });
});
