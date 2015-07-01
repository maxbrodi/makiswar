 $( document ).ready(function() {
  // ajustement de la hauteur des divs
  var fightSize = $('.fight-display').width();
  var infoHeight = $(window).innerHeight() - fightSize;

  $('.fight-display').css("height", fightSize);
  $('.weapon-selection').css("height", infoHeight);

  infoHeight = $('.weapon-selection').height();
  var itemSelectionHeight = infoHeight - 70;

  $('.item-selection-box').css("height", itemSelectionHeight);
  if (itemSelectionHeight < 150 ){
    $('.item-attack-display').addClass('hidden')
    $('h2').addClass('smalldevice')
  };
});
