var ready;
ready = function(){
  $('#side_top_seats').hide();
  $('#side_bottom_seats').hide();
  $('#simple_seats').hide();

  $('#coach_type').change(function(){
    switch ($(this).val()) {
      case 'CompartmentCoach':
        $('#top_seats').show();
        $('#bottom_seats').show();
        $('#side_top_seats').hide();
        $('#side_bottom_seats').hide();
        $('#simple_seats').hide();
        break;
      case 'EconomyCoach':
        $('#top_seats').show();
        $('#bottom_seats').show();
        $('#side_top_seats').show();
        $('#side_bottom_seats').show();
        $('#simple_seats').hide();
        break;
      case 'SleepingCoach':
        $('#top_seats').hide();
        $('#bottom_seats').show();
        $('#side_top_seats').hide();
        $('#side_bottom_seats').hide();
        $('#simple_seats').hide();
        break;
      case 'SuburbanCoach':
        $('#top_seats').hide();
        $('#bottom_seats').hide();
        $('#side_top_seats').hide();
        $('#side_bottom_seats').hide();
        $('#simple_seats').show();
        break;
    }
  });
};

document.addEventListener("turbolinks:load", ready); 
