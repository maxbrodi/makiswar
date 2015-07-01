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

  // click sur un maki
  $('.cell').click(function() {
    // get cell coord
    var cell_coord = $( this ).data('cell');
    // hide previous cell info
    $('.cell-info').addClass( "hidden" );
    // show or hide clicked cell info
    $('#cell-info-' + cell_coord).removeClass( "hidden" );
    // show or hide news info
    if( $('#cell-info-' + cell_coord).is(":visible")) {
      $('.news-info').addClass( "hidden" );
    }
    else {
      $('.news-info').removeClass( "hidden" );
    };
  });

});
