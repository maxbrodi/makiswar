$( document ).ready(function() {
  // ajustement de la hauteur des divs
  var cellwidth = $('.cell').width();
  $('.cell').css("height", cellwidth);
  $('.worldmap').css("height", cellwidth*5);

  // affichage du maki du joueur
  // on recupere son crew
  var player_crew = $('#player').data('playercrew');
  // on l'affiche
  $('#player').addClass(player_crew);

  // affichage des autres makis
  $('.cell-info').each(function( index ) {
    // coordonnees
    var x = $( this ).data('x');
    var y = $( this ).data('y');
    // differents crews
    var crew = $( this ).data('crew');
    // affichage
    $('*[data-cell="'+ x + y + '"]').addClass(crew);
  });

});
