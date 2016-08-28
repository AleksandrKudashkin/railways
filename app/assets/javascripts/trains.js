var ready;
ready = function(){
  $('a.edit_train').click(function(e){
    e.preventDefault();
    var train_id;
    var form;
    var number;

    train_id = $(this).data('trainId');
    form = $('#edit_train_' + train_id);
    number = $('#train_number_' + train_id);

    if (!$(this).hasClass('cancel')){
      $(this).html('Cancel');
      $(this).toggleClass('cancel');
    } else {
      $(this).html('Edit');
      $(this).toggleClass('cancel');
    }

    number.toggle();
    form.toggle();
  });
};
document.addEventListener("turbolinks:load", ready); 
