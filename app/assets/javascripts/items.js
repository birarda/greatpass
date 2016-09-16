$(document).on('turbolinks:load', function() {
  $('.unveil-img').unveil(100);

  $('#search__kind').change(function(){
    // the kind has just been changed
    var newKinds = $(this).val();

    if (newKinds) {
      // first we filter the image panels to show only the selected kinds
      $('.kind-panel').each(function(){

        var thisKindID = $(this).data('kind-id');

        if (newKinds.indexOf(thisKindID.toString()) == -1) {
          $(this).hide();
        } else {
          $(this).show();
        }
      });
    } else {
      $('.kind-panel').show();
    }
  });
});

$(document).on('turbolinks:before-cache', function() {
  $(window).off('unveil');

});
