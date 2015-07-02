 $( document ).ready(function() {
  fight_display();
 });

 function fight_display() {
  // ajustement de la hauteur des divs
  var fightSize = $('.fight-display').width();
  var infoHeight = $(window).innerHeight() - fightSize;

  $('.fight-display').css("height", fightSize);
  $('.weapon-selection').css("height", infoHeight);

  infoHeight = $('.weapon-selection').height();
  var itemSelectionHeight = infoHeight - 4;

  $('.item-selection-box').css("height", itemSelectionHeight);
  if (itemSelectionHeight < 170 ){
    $('.item-attack-display').addClass('hidden')
    $('.item-selection-box').addClass('smalldevice')
  };

  $('#after-attack-message').click(function() {
    $('#after-attack-message').toggleClass('hidden');
  });

  // old toggle message

  // $('.item-selection-box').click(function() {
  //   $('#confirm-attack').toggleClass('hidden');
  //   var item_number = $( this ).data('number');
  //   $('#confirm-attack').html( "<p>Tap to use</p><p>" + $('.item-n' + item_number + ' h2').first().text() + "!</p>" );
  // });
}

