// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('turbolinks:load', function() {

  var $selectized_selects = [$('#search__item_id'), $('#search__certification'), $('#search__paint_color'), $('#search__rare_class'), $('#search__platform'), $('#search__kind')]
  $.each($selectized_selects, function(index, $select){
    $select.selectize({
      closeAfterSelect: true,
      onDropdownClose: function(dropdown) {
        $(dropdown).prev().find('input').blur();
      },
      sortField: 'text'
    });
  });

  // grab the initial options from the selectize object for item
  var itemSelectize = $('#item-selection .selectized')[0].selectize;

  var allItems = itemSelectize.options;
  console.log(allItems);

  $('#search__kind').change(function(){
    // now we filter the list of items that can be selected to match the selected kinds
    var newKinds = $(this).val();

    var filteredItems = [];

    $.each(allItems, function(itemID, value){
      // use the itemKinds Object to see what kind this is
      var kind = itemKinds[itemID];

      if (!newKinds || newKinds.indexOf(kind.toString()) != -1) {
        filteredItems.push({
          value: itemID,
          text: value.text
        })
      }
    });

    itemSelectize.clearOptions();
    itemSelectize.load(function(callback){
      callback(filteredItems);
    });
  });
});


$(document).on('turbolinks:before-cache', function() {
  $('.selectized').each(function() {
    this.selectize.destroy();
  });
});
