$(document).on('turbolinks:load', function() {

  $('#user-messages tr.message-row').click(function(event){
    if (!$(event.target).is('a') && !$(event.target).is('span.glyphicon')) {
      window.location = $(this).data('conversation-link');
    }
  });

  $('#message-reply-form').on('ajax:success', function(event, data, status, xhr){
    location.reload();
  }).on('ajax:error', function(event, xhr, status, error){
    if (xhr.responseJSON['errors']) {
      errorHTML = ""

      $.each(xhr.responseJSON['errors'], function(index, errorText){
        errorHTML += "<p>" + errorText + "</p>"
      });
    } else {
      errorHTML = "<p>There was a problem sending your message. Please try again.</p>"
    }

    // full the errors and show the message form
    $('#message-form-errors').html(errorHTML);
    $('#message-form-errors').show();
  });
});
