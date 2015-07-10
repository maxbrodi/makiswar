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

    // check if user is on item on load


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

    // iphone 6 - Chrome
    if (infoHeight <= 225 && infoHeight > 200){
      $('.transportation-options .img-options-display').css('width', '40%');
      $('.transportation-options .img-options-display').css('margin-top', '1.2em');
      $('.transportation-options .img-options-display').css('margin-bottom', '1em');
      $('.my-maki .img-options-display').css('width', '40%');
      $('.my-maki .img-options-display').css('margin-top', '1.5em');
      $('.my-maki .img-options-display').css('margin-bottom', '1.5em');
    };

    // iphone 6 - Safari
    if (infoHeight <= 200 && infoHeight > 175){
      $('.transportation-options .img-options-display').css('width', '35%');
      $('.transportation-options .img-options-display').css('margin-top', '1em');
      $('.transportation-options .img-options-display').css('margin-bottom', '0.7em');
      $('.my-maki .img-options-display').css('width', '35%');
      $('.my-maki .img-options-display').css('margin-top', '1em');
      $('.my-maki .img-options-display').css('margin-bottom', '1em');
    };

    // iphone 5 - Chrome
    if (infoHeight <= 175 && infoHeight > 165 ){
      $('.transportation-options .img-options-display').css('width', '35%');
      $('.transportation-options .img-options-display').css('margin-top', '0.8em');
      $('.transportation-options .img-options-display').css('margin-bottom', '0.5em');
      $('.my-maki .img-options-display').css('width', '35%');
      $('.my-maki .img-options-display').css('margin-top', '1em');
      $('.my-maki .img-options-display').css('margin-bottom', '1em');
    };

    // iphone 5 - Safari
    if (infoHeight <= 165 && infoHeight > 125 ){
      $('.transportation-options .img-options-display').css('width', '25%');
      $('.transportation-options .img-options-display').css('margin-top', '0.5em');
      $('.transportation-options .img-options-display').css('margin-bottom', '0.5em');
      $('.my-maki .img-options-display').css('width', '25%');
      $('.my-maki .img-options-display').css('margin-top', '0.8em');
      $('.my-maki .img-options-display').css('margin-bottom', '0.8em');
    };

    // iphone 4 - all browser
    if (infoHeight <= 125 && infoHeight ){
      $('.cell-info img').addClass('hidden');
      $('.othermaki-info h3').addClass('hidden');

      $('.othermaki-info .attack-opponent').css('position', 'relative');
      $('.othermaki-info .attack-opponent').css('width', '100%');
      $('.othermaki-info .attack-opponent').css('left', '-50px');
      $('.othermaki-info .attack-opponent').css('top', '-12px');
      $('.othermaki-info .attack-opponent').css('padding', '2px');

      $('.transportation-options .img-options-display').addClass('hidden');
      $('.transportation-options .items_count').addClass('hidden');
      $('.transportation-options .consumption').addClass('hidden');
      $('.transportation-options .confirm-action').css('position', 'relative');
      $('.transportation-options .not-possible').css('position', 'relative');
      $('.transportation-options .text-white-shadow').css('position', 'relative');
      $('.transportation-options .confirm-action').css('padding', '2px');
      $('.transportation-options .confirm-action').css('top', '4px');
      $('.transportation-options .not-possible').css('padding', '2px');
      $('.transportation-options .not-possible').css('top', '6px');
      $('.transportation-options .text-white-shadow').css('padding', '2px');
      $('.transportation-options .text-white-shadow').css('top', '-26px');
      $('.transportation-options .text-white-shadow').html('Come on Maki!');

      $('.my-maki .img-options-display').addClass('hidden');
      $('.my-maki .confirm-action').css('position', 'relative');
      $('.my-maki .confirm-action').css('padding', '2px');
      $('.my-maki .confirm-action').css('top', '12px');
      $('.my-maki .text-white-shadow').css('position', 'relative');
      $('.my-maki .text-white-shadow').css('padding', '2px');
      $('.my-maki .text-white-shadow').css('top', '10px');
    };

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

    // A enlever si on souhaite afficher le présentateur en intro
    if ($('#player').hasClass('item')) {
      console.log('yo')
      $('.grab-item').removeClass('hidden');
      $('.search-item').addClass('hidden');
    }
    else {
      console.log('ya')
      $('.search-item').removeClass('hidden');
      $('.grab-item').addClass('hidden');
    };
    // Fin du code a enlever
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
