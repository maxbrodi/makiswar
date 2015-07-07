 $( document ).ready(function() {


  function fightDisplay() {
    // ajustement de la hauteur des divs
    var fightSize = $('.fight-display').width();
    var infoHeight = $(window).innerHeight() - fightSize;

    $('.fight-display').css("height", fightSize);
    $('.weapon-selection').css("height", infoHeight);

    infoHeight = $('.weapon-selection').height();
    var itemSelectionHeight = infoHeight - 4;

    $('.item-selection-box').css("height", itemSelectionHeight);
    if (itemSelectionHeight < 200 ){
      // $('.item-attack-display').addClass('hidden')
      // $('.item-selection-box').addClass('smalldevice')
      $('.confirm-attack').css('margin-top', '0.5em');
      $('.item-attack-display').css('padding-top', '13px');
      $('.confirm-attack').css('padding', '5px 13%');
      $('.needs').css('margin-top', '0.5em');
      $('#killed').css('padding-top', '0%');
    };

    $('.fights-container').click(function() {
      $('#after-attack-message').addClass('hidden');
    });

  };

  // old toggle message

  // $('.item-selection-box').click(function() {
  //   $('#confirm-attack').toggleClass('hidden');
  //   var item_number = $( this ).data('number');
  //   $('#confirm-attack').html( "<p>Tap to use</p><p>" + $('.item-n' + item_number + ' h2').first().text() + "!</p>" );
  // });

  fightDisplay();

  PubSub.subscribe('fightDisplay', function(){
    fightDisplay();
  });
 });

