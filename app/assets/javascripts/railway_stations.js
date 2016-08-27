$(document).ready(function(){
  $('a.edit_station').click(function(e){
    e.preventDefault();
    var station_id;
    var form;
    var title;

    stationId = $(this).data('stationId');
    form = $('#edit_railway_station_' + stationId);
    title = $('#railway_station_title_' + stationId);

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
});
