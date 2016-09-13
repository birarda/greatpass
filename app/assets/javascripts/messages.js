$(document).on('turbolinks:load', function() {
  $('body').on('click', '.message-button', function(){
    $('#message-modal-title').html('Message ' + $(this).data('receiver-name'));
    $('#message__receiver_id').val($(this).data('receiver-id'));
  });

  $('#message-modal').on('shown.bs.modal', function() {
    $('#message_subject').focus();
  });

  $('#message-modal-form').on('ajax:success', function(event, data, status, xhr){
    $('#message-modal').modal('hide');
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
