var ready;
ready = function(){
  $('a.edit_route').click(function(e){
    e.preventDefault();
    var route_id;
    var form;
    var name;

    route_id = $(this).data('routeId');
    form = $('#edit_route_' + route_id);
    name = $('#route_name_' + route_id);

    if (!$(this).hasClass('cancel')){
      $(this).html('Cancel');
      $(this).toggleClass('cancel');
    } else {
      $(this).html('Edit');
      $(this).toggleClass('cancel');
    }

    name.toggle();
    form.toggle();
  });
};
document.addEventListener("turbolinks:load", ready); 
