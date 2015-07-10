$(function() {

  function setWorld() {
    // définition des variables utiles
    var cellwidth = $('.cell').width();
    var worldSize = cellwidth*5;
    var infoHeight = $(window).innerHeight() - worldSize;
    var x_shift = $('#player').data('shift-x');
    var y_shift = $('#player').data('shift-y');
    var x_bg = parseInt($('#player').data('cell').toString().split('')[0]) + x_shift
    var y_bg = parseInt($('#player').data('cell').toString().split('')[1]) + y_shift

    // ajustement de la hauteur des divs + position du joueur sur le background
    $('.cell').css("height", cellwidth);
    $('.worldmap').css("height", worldSize);
    $('.items-list').css("height", worldSize);
    $('.worldmap').css("background-size", cellwidth * 20);
    $('.worldmap').css("background-position-x", (-x_bg * cellwidth)+(3*cellwidth));
    $('.worldmap').css("background-position-y", (-y_bg * cellwidth)+(3*cellwidth));
    $('.new-move').css("height", infoHeight);
    $('.my-maki').css("height", infoHeight);
    $('.transportation-options').css("height", infoHeight);
    $('.info-bottom').css("height", infoHeight);
    $('.info-bottom').css("width", worldSize);

    if (infoHeight <= 220 && infoHeight > 200){
      $('.transportation-options .img-options-display').css('width', '35%');
      $('.transportation-options .img-options-display').css('margin-top', '0.7em');
      $('.transportation-options .img-options-display').css('margin-bottom', '0.7em');
      $('.my-maki .img-options-display').css('width', '30%');
      $('.my-maki .img-options-display').css('margin-top', '0.8em');
      $('.my-maki .img-options-display').css('margin-bottom', '0.8em');
    };

    // if (infoHeight <= 200 && infoHeight > 200){
    //   $('.transportation-options .img-options-display').css('width', '30%');
    //   $('.transportation-options .img-options-display').css('margin-top', '0.5em');
    //   $('.transportation-options .img-options-display').css('margin-bottom', '0.5em');
    //   $('.my-maki .img-options-display').css('width', '30%');
    //   $('.my-maki .img-options-display').css('margin-top', '0.8em');
    //   $('.my-maki .img-options-display').css('margin-bottom', '0.8em');
    // };

    // if (infoHeight <= 180 && infoHeight > 200 ){
    //   $('.transportation-options .img-options-display').css('width', '30%');
    //   $('.transportation-options .img-options-display').css('margin-top', '0.5em');
    //   $('.transportation-options .img-options-display').css('margin-bottom', '0.5em');
    //   $('.my-maki .img-options-display').css('width', '30%');
    //   $('.my-maki .img-options-display').css('margin-top', '0.8em');
    //   $('.my-maki .img-options-display').css('margin-bottom', '0.8em');
    // };

    // afficher les limites du monde
    $('.cell').each(function() {
      var x_math = parseInt($(this).data('cell').toString().split('')[0]) + x_shift
      var y_math = parseInt($(this).data('cell').toString().split('')[1]) + y_shift
      if ( x_math <= 0 || x_math > 20 || y_math <= 0 || y_math > 20) {
        $(this).addClass('outta-world');
      };
    });

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

    // affichage des items
    $('.item-info').each(function(index) {
      var x = $( this ).data('x');
      var y = $( this ).data('y');
      $('*[data-cell="'+ x + y + '"]').addClass('item');
    });

    // interaction du joueur avec la map
    $('.cell').click(function() {
      var cell = $(this);
      showCell(cell);
    });

    $('.open-close').click(function() {
      openCloseItemsList();
    });
  };

  function showCell(cell) {
    var cell_coord = cell.data('cell');
    $('.cell').removeClass('selected');
    cell.addClass('selected');

    if (cell.hasClass('maki')) {
      $('.my-maki').addClass("hidden");
      $('.new_position').removeAttr('value');
      $('.cell-info').addClass("hidden");
      $('.new-move').addClass("hidden");
      $('.news-info').addClass("hidden");
      $('#cell-info-' + cell_coord).removeClass("hidden");
      if (cell.hasClass('welcome')) {
        $('#cell-info-' + cell_coord + ' input').removeClass("hidden");
      }
    }
    else if (cell.not('.outta-world').hasClass('welcome')) {
      $('.my-maki').addClass("hidden");
      $('.cell-info').addClass("hidden");
      $('.news-info').addClass("hidden");
      $('.new-move').removeClass("hidden");
      $('.new_position').val(cell_coord);
    }
    else if (cell.is('#player')) {
      $('.cell-info').addClass("hidden");
      $('.new-move').addClass("hidden");
      $('.news-info').addClass("hidden");
      $('.my-maki').removeClass("hidden");
      if (cell.hasClass('item')) {
        $('.search-item').addClass("hidden");
        $('.grab-item').removeClass("hidden");
      }
    }
    else if (cell.hasClass('.outta-world')) {
      $('.outta-world').not('.selected').addClass('around-selection');
      $('.my-maki').addClass("hidden");
      $('.new_position').removeAttr('value');
      $('.cell-info').addClass("hidden");
      $('.new-move').addClass("hidden");
      $('.news-info').removeClass("hidden");
    }
    else {
      $('.my-maki').addClass("hidden");
      $('.new_position').removeAttr('value');
      $('.cell-info').addClass("hidden");
      $('.new-move').addClass("hidden");
      $('.news-info').removeClass("hidden");
    };
  }

  function openCloseItemsList() {
    $('.items-list').toggleClass("hidden");
    $('.open-close').toggleClass('hidden');
  };

  function afterGrab() {
    if ($('#player').hasClass('item')) {
      openCloseItemsList();
    }
    showCell($('#player'));
  };

  function displayHideJauge() {
    $("#jauge-holder").on("click", function(){
      $(".cell[data-cell='51']").click();
    });
    $("#life-holder").on("click", function(){
      $(".cell[data-cell='11']").click();
    });
    $("#pin").on("click", function(){
      $(".cell[data-cell='32']").click();
    });
  };

  setWorld();
  displayHideJauge();

  PubSub.subscribe('setWorld', function(){
    setWorld();
    displayHideJauge();
  });

  PubSub.subscribe('afterGrab', function(){
    afterGrab();
  });

});
