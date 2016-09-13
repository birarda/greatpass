$(document).on('turbolinks:load', function() {

  $('#user-messages tr.message-row').click(function(event){
    console.log($(event.target));
    if (!$(event.target).is('a') && !$(event.target).is('span.glyphicon')) {
      window.location = $(this).data('conversation-link');
    }
  });
});
