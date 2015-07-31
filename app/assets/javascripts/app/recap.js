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

      // var mainMessage = $('.recap').width();
      // var infoHeight = $(window).innerHeight() - mainMessage;
      // $('.recap').css("height", mainMessage);
      // $('.action').css("height", infoHeight);
    };
    $('.crew-change').css('height', '50%');
    $('.crew-change').css('width', '62%');
    // changing crew
    $('.makishake').click(function() {
      $('.makishake').addClass('hidden');
      $('.placeholder-new-crew').removeClass('hidden');
      $('.new-crew').removeClass('hidden');
      setTimeout(function() {
        $('.placeholder-new-crew').addClass('hidden');
        $('.new-crew-delay').removeClass('hidden');
      }, 1200);
    });
  };

  recapDisplay();

 });
