$(document).on('turbolinks:load', function() {
  $('.message-button').click(function(){
    $('#message-modal-title').html('Message ' + $(this).data('receiver-name'));
    $('#message__receiver_id').val($(this).data('receiver-id'));
  });
});
