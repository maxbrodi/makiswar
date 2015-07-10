$(document).ready(function() {


  function profileDisplay() {
    // ajustement de la hauteur des divs
    var profileSize = $('.my-profile-main').width();
    var infoHeight = $(window).innerHeight() - profileSize;
    $('.my-profile-main').css("height", profileSize);
    $('.maki-in-landscape').css("height", profileSize);
    $('.my-items-list').css("height", profileSize);
    $('.my-profile-menu').css("height", infoHeight);

    if (infoHeight <= 220 && infoHeight > 200){
      $('.my-profile-menu .img-options-display').css('width', '30%');
      $('.my-profile-menu .img-options-display').css('margin-top', '0.8em');
      $('.my-profile-menu .img-options-display').css('margin-bottom', '0.8em');
    };

    if (infoHeight <= 200 && infoHeight > 200){
      $('.my-profile-menu .img-options-display').css('width', '30%');
      $('.my-profile-menu .img-options-display').css('margin-top', '0.8em');
      $('.my-profile-menu .img-options-display').css('margin-bottom', '0.8em');
    };

    if (infoHeight <= 180 && infoHeight > 200 ){
      $('.my-profile-menu .img-options-display').css('width', '30%');
      $('.my-profile-menu .img-options-display').css('margin-top', '0.8em');
      $('.my-profile-menu .img-options-display').css('margin-bottom', '0.8em');
    };


    // Animation maki
    $('#maki-avatar').click(function() {
      $(this).toggleClass('bounce');
      $(this).toggleClass('floating');
    });

    $('.my-open-close').click(function() {
      openCloseMyItemsList();
    });
  };

  function openCloseMyItemsList() {
    $('.my-items-list').toggleClass("hidden");
    $('.my-open-close').toggleClass('hidden');
    $('.profile-info-crew').toggleClass('hidden');
  };

  profileDisplay();

 });
