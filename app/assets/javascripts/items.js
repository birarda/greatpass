$(document).on('turbolinks:load', function() {
  $('.unveil-img').unveil(100);

  var currentKindStrings = null;

  $('#search__kind').change(function(){
    // the kind has just been changed
    currentKindStrings = $(this).val();

    if (currentKindStrings) {
      // first we filter the image panels to show only the selected kinds
      $('.kind-panel').each(function(){

        var thisKindID = $(this).data('kind-id');

        if (currentKindStrings.indexOf(thisKindID.toString()) == -1) {
          $(this).hide();
        } else {
          $(this).show();
        }
      });
    } else {
      $('.kind-panel').show();
    }

    // no matter what we need to re-trigger unveil in case some things have become visible
    $(window).trigger("lookup");
  });

  $('#search__item_id').change(function(){
    // the selected items have just been changed
    var newItems = $(this).val();

    var visibleKinds = [];

    if (newItems) {
      // hide all item tiles
      $('.item-col').hide();

      $.each(newItems, function(index, itemID){
        // show the item tile for matching item
        $('.item-col[data-item-id=' + itemID + ']').show();
        visibleKinds.push(itemKinds[parseInt(itemID)]);
      });
    } else {
      $('.item-col').show();
    }

    $('.kind-panel').each(function(){
      var thisKindID = $(this).data('kind-id');

      if (!newItems) {
        if (!currentKindStrings || currentKindStrings.indexOf(thisKindID.toString()) != -1) {
          $(this).show();
        } else {
          $(this).hide();
        }
      } else if (visibleKinds.indexOf(thisKindID) != -1) {
        $(this).show();
      } else {
        $(this).hide();
      }
    })
  });
});

$(document).on('turbolinks:before-cache', function() {
  $(window).off('unveil');
});
