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

    // tuto scenes
    $('.tuto_scene1').click(function() {
      $('.tuto_scene1').addClass("hidden");
      $('.tuto_scene2').removeClass("hidden");
    });
    $('.tuto_scene2').click(function() {
      $('.tuto_scene2').addClass("hidden");
      $('.tuto_scene3').removeClass("hidden");
    });
    $('.tuto_scene3').click(function() {
      $('.tuto_scene3').addClass("hidden");
      $('.tuto_scene4').removeClass("hidden");
    });


    // computer
    if (infoHeight > 300 && infoHeight <= 350){
      $('body').css('padding-top', '2%');
    };
    if (infoHeight > 350){
      $('body').css('padding-top', '4%');
    };


  };

  recapDisplay();

 });
