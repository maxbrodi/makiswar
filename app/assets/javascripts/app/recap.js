$( document ).ready(function() {


  function recapDisplay() {
    // ajustement de la hauteur des divs
    var mainMessage = $(window).innerHeight() * 0.7 ;
    var infoHeight = $(window).innerHeight() - mainMessage;

    $('.recap').css("height", mainMessage);
    $('.action').css("height", infoHeight);

    if (infoHeight < 200 ){
      $('#resurrect').css('margin-top', '0.5em');
    };


  };

  recapDisplay();

 });
