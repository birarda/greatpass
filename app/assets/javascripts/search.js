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
  var $rawItemSelect = $('#item-selection .selectized');
  var itemSelectize = $rawItemSelect[0].selectize;

  var allItems = itemSelectize.options;

  $('#search__kind').change(function(){
    // now we filter the list of items that can be selected to match the selected kinds
    var newKinds = $(this).val();

    var filteredItems = [];

    // before we clear, we need to remember what was selected
    var itemsSelectedBefore = $rawItemSelect.val();

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

    var newSelection = [];

    // okay, now we need to re-select whatever was selected before
    // as long as the kinds match
    $.each(itemsSelectedBefore, function(index, itemIDString){
      var itemID = parseInt(itemIDString)
      var itemKind = itemKinds[itemID];

      if (!newKinds || newKinds.indexOf(itemKind.toString()) != -1) {
        newSelection.push(itemIDString);
      }
    });

    itemSelectize.setValue(newSelection);
  });
});


$(document).on('turbolinks:before-cache', function() {
  $('.selectized').each(function() {
    this.selectize.destroy();
  });
});
