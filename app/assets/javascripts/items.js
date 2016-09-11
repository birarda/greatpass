$(document).on('turbolinks:load', function() {
  $('.unveil-img').unveil(100);
});

$(document).on('turbolinks:before-cache', function() {
  $(window).off('unveil');
});
