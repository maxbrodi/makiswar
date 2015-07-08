 $( document ).ready(function() {


  function fightDisplay() {
    // ajustement de la hauteur des divs
    var fightSize = $('.fight-display').width();
    var infoHeight = $(window).innerHeight() - fightSize;

    $('.fight-display').css("height", fightSize);
    $('.the-fight').css("height", infoHeight);
    $('.weapon-options').css("height", infoHeight);

    if (infoHeight < 200 ){
      $('.weapon-options .img-options-display').css('margin-top', '1.2em');
      $('.weapon-options .img-options-display').css('margin-bottom', '0.3em');
      $('.weapon-options .img-options-display').css('width', '35%');
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

