 $( document ).ready(function() {


  function fightDisplay() {
    // ajustement de la hauteur des divs
    var fightSize = $('.fight-display').width();
    var infoHeight = $(window).innerHeight() - fightSize;

    $('.fight-display').css("height", fightSize);
    $('.the-fight').css("height", infoHeight);
    $('.weapon-options').css("height", infoHeight);

    // iphone 6 - Chrome
    if (infoHeight <= 225 && infoHeight > 200){
      $('.weapon-options .img-options-display').css('width', '40%');
      $('.weapon-options .img-options-display').css('margin-top', '1.2em');
      $('.weapon-options .img-options-display').css('margin-bottom', '1.2em');
      $('#killed').css('padding-top', '0%');
    };

    // iphone 6 - Safari
    if (infoHeight <= 200 && infoHeight > 175){
      $('.weapon-options .img-options-display').css('width', '35%');
      $('.weapon-options .img-options-display').css('margin-top', '1em');
      $('.weapon-options .img-options-display').css('margin-bottom', '1em');
      $('#killed').css('padding-top', '0%');
    };

    // iphone 5 - Chrome
    if (infoHeight <= 175 && infoHeight > 165 ){
      $('.weapon-options .img-options-display').css('width', '35%');
      $('.weapon-options .img-options-display').css('margin-top', '1em');
      $('.weapon-options .img-options-display').css('margin-bottom', '0.3em');
      $('#killed').css('padding-top', '0%');
    };

    // iphone 5 - Safari
    if (infoHeight <= 165 && infoHeight > 125 ){
      $('.weapon-options .img-options-display').css('width', '25%');
      $('.weapon-options .img-options-display').css('margin-top', '0.8em');
      $('.weapon-options .img-options-display').css('margin-bottom', '0.3em');
      $('#killed').css('padding-top', '0%');
    };

    // iphone 4 - all browser
    if (infoHeight <= 125 && infoHeight ){
      $('.weapon-options .img-options-display').css('width', '10%');
      $('.weapon-options .img-options-display').css('margin-top', '0.1em');
      $('.weapon-options .img-options-display').css('margin-bottom', '0.1em');
      $('#killed').css('padding-top', '0%');
    };

    $('.fights-container').click(function() {
      $('#after-attack-message').addClass('hidden');
    });

  };

  fightDisplay();

  PubSub.subscribe('fightDisplay', function(){
    fightDisplay();
  });
 });

