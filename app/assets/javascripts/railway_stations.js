var ready;
ready = function() {
  $('a.edit_station').click(function(e){
    e.preventDefault();
    var station_id;
    var form;
    var title;

    station_id = $(this).data('stationId');
    form = $('#edit_railway_station_' + station_id);
    title = $('#railway_station_title_' + station_id);

    if (!$(this).hasClass('cancel')){
      $(this).html('Cancel');
      $(this).toggleClass('cancel');
    } else {
      $(this).html('Edit');
      $(this).toggleClass('cancel');
    }

    title.toggle();
    form.toggle();
  });
};

document.addEventListener("turbolinks:load", ready); 
