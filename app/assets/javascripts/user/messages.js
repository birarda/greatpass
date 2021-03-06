$(document).on('turbolinks:load', function() {

  $('#user-messages tr.message-row').click(function(event){
    if (!$(event.target).is('a') && !$(event.target).is('span.glyphicon')) {
      window.location = $(this).data('thread-link');
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

  $modal = $('#notification-toggle-modal');
  $modalText = $modal.find('.modal-body p');

  $('body').on('click', '#resend-confirmation-button', function(){
    $.post('/user/resend_confirmation', function(data){
      $('.resend-button-paragraph').html('Check your inbox for your confirmation email.');
    });

    $(this).blur();
  });

  $('#email-notifications-button').click(function(){
    // setup a post to toggle email notifications for messages
    var isDisabled = $(this).find('.checked-glyph').hasClass('glyphicon-unchecked');
    var $button = $(this);

    // disable the button and show the spinner
    $button.addClass('loading');
    $button.prop('disabled', true);

    $.post('/user/threads/settings', {
      email_notifications: isDisabled
    }).done(function(data){
      // read what the setting is now and update the button
      var notificationsEnabled = data['settings']['email_notifications_enabled'];

      var glyphSpan = $button.find('.checked-glyph')

      if (notificationsEnabled) {
        glyphSpan.addClass('glyphicon-check');
        glyphSpan.removeClass('glyphicon-unchecked');
      } else {
        glyphSpan.addClass('glyphicon-unchecked');
        glyphSpan.removeClass('glyphicon-check');
      }
    }).fail(function(xhr){

      if (xhr.responseJSON && 'email_confirmed' in xhr.responseJSON && !xhr.responseJSON['email_confirmed']) {
        // user doesn't have a confirmed email, needs to do that first
        // show a modal so they know that they need to fix it

        confirmText = "<p>You must confirm your email before you can enable email notifications.</p>";
        confirmText += "<p class='resend-button-paragraph'><button id='resend-confirmation-button' class='btn btn-default'>Re-send confirmation email</button></p>";

        $modalText.html(confirmText);

      } else {
        $modalText.html("There was a problem changing your notfication settings. Please try again.");
      }

      $modal.modal();
    }).always(function(data, textStatus, error){
      // re-enable the button so it can be clicked again
      $button.prop('disabled', false);
      $button.removeClass('loading');
    });

    $(this).blur();
  });
});

$(document).on('turbolinks:before-cache', function() {
  $('.modal').hide();
  $('.modal-backdrop').remove();
});
