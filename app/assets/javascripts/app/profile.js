$( document ).ready(function() {


  function profileDisplay() {
    // ajustement de la hauteur des divs
    var profileSize = $('.maki-in-landscape').width();
    var infoHeight = $(window).innerHeight() - profileSize;
    // var mainMessage = landscapeWidth

    $('.profile').css("height", profileSize);
    $('.action').css("height", infoHeight);

    // if (infoHeight < 200 ){
    //   $('#resurrect').css('margin-top', '0.5em');
    // };


  };

  profileDisplay();

 });
