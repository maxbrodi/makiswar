$( document ).ready(function() {


  function recapDisplay() {
    // ajustement de la hauteur des divs
    var landscapeWidth = $('.maki-in-landscape').width();
    var mainMessage = landscapeWidth
    var infoHeight = $(window).innerHeight() - landscapeWidth;

    $('.profile').css("height", mainMessage);
    $('.action').css("height", infoHeight);

    // if (infoHeight < 200 ){
    //   $('#resurrect').css('margin-top', '0.5em');
    // };


  };

  recapDisplay();

 });
