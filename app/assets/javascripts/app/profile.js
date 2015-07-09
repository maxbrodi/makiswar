$(document).ready(function() {


  function profileDisplay() {
    // ajustement de la hauteur des divs
    var profileSize = $('.my-profile-main').width();
    var infoHeight = $(window).innerHeight() - profileSize;

    $('.my-profile-main').css("height", profileSize);
    $('.maki-in-landscape').css("height", profileSize);
    $('.my-items-list').css("height", profileSize);
    $('.my-profile-menu').css("height", infoHeight);


    // if (infoHeight < 200 ){
    //   $('#resurrect').css('margin-top', '0.5em');
    // };
  };

  profileDisplay();

 });
