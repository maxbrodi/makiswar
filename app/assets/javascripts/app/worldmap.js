$( document ).ready(function() {
  // ajustement de la hauteur des divs
  var cellwidth = $('.cell').width();
  var worldSize = cellwidth*5;
  var infoHeight = $(window).innerHeight() - worldSize;
  $('.cell').css("height", cellwidth);
  $('.worldmap').css("height", worldSize);
  $('.info-bottom').css("height", infoHeight);

  // affichage du maki du joueur
  var player_crew = $('#player').data('playercrew');
  $('#player').addClass(player_crew);

  // affichage des autres makis
  $('.cell-info').each(function(index) {
    var x = $( this ).data('x');
    var y = $( this ).data('y');
    var crew = $( this ).data('crew');
    $('*[data-cell="'+ x + y + '"]').addClass(crew);
    $('*[data-cell="'+ x + y + '"]').addClass('maki');
  });

  // afficher les limites du monde
  var x_shift = $('#player').data('shift-x');
  var y_shift = $('#player').data('shift-y');
  $('.cell').each(function() {
    var x_math = parseInt($(this).data('cell').toString().split('')[0]) + x_shift
    var y_math = parseInt($(this).data('cell').toString().split('')[1]) + y_shift
      if ( x_math <= 0 || x_math > 20 || y_math <= 0 || y_math > 20) {
      $(this).addClass('outta-world');
    };
  });

  // interaction du joueur avec la map
  $('.cell').click(function() {
    var cell = $(this)
    var cell_coord = $(this).data('cell');
    $('.cell').removeClass('selected');
    cell.addClass('selected');

    if (cell.hasClass('maki')) {
      $('#new_position').removeAttr('value');
      $('.cell-info').addClass("hidden");
      $('.new-move').addClass("hidden");
      $('.news-info').addClass("hidden");
      $('#cell-info-' + cell_coord).removeClass("hidden");
    }
    else if (cell.not('.outta-world').hasClass('welcome')) {
      $('.cell-info').addClass("hidden");
      $('.news-info').addClass("hidden");
      $('.new-move').removeClass("hidden");
      $('#new_position').val(cell_coord);
    }
    else {
      $('#new_position').removeAttr('value');
      $('.cell-info').addClass("hidden");
      $('.new-move').addClass("hidden");
      $('.news-info').removeClass("hidden");
    };
  });
});
