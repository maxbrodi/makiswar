$( document ).ready(function() {


  function recapDisplay() {
    // ajustement de la hauteur des divs
    var mainMessage = $('.recap').width() + 110;
    var infoHeight = $(window).innerHeight() - mainMessage;

    $('.recap').css("height", mainMessage);
    $('.action').css("height", infoHeight);

    if (infoHeight < 200 ){
      $('#resurrect').css('margin-top', '-0.5em');
      $('.crew-change').css('height', '45%');
    };

    if (infoHeight < 200 ){
      var mainMessage = $('.recap').width();
      var infoHeight = $(window).innerHeight() - mainMessage;
      $('.recap').css("height", mainMessage);
      $('.action').css("height", infoHeight);
    };

    // changing crew
    $('.makishake').click(function() {
      $('.makishake').addClass('hidden');
      $('.new-crew').removeClass('hidden');
    });
  };

  recapDisplay();

 });
