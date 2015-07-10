$(document).ready(function() {


  function profileDisplay() {
    // ajustement de la hauteur des divs
    var profileSize = $('.my-profile-main').width();
    var infoHeight = $(window).innerHeight() - profileSize;
    $('.my-profile-main').css("height", profileSize);
    $('.maki-in-landscape').css("height", profileSize);
    $('.my-items-list').css("height", profileSize);
    $('.my-profile-menu').css("height", infoHeight);

    // iphone 6 - Chrome
    if (infoHeight <= 225 && infoHeight > 200){
      $('.my-profile-menu .img-options-display').css('width', '40%');
      $('.my-profile-menu .img-options-display').css('margin-top', '1.2em');
      $('.my-profile-menu .img-options-display').css('margin-bottom', '1.2em');
      $('#killed').css('padding-top', '0%');
    };

    // iphone 6 - Safari
    if (infoHeight <= 200 && infoHeight > 175){
      $('.my-profile-menu .img-options-display').css('width', '35%');
      $('.my-profile-menu .img-options-display').css('margin-top', '1em');
      $('.my-profile-menu .img-options-display').css('margin-bottom', '1em');
      $('#killed').css('padding-top', '0%');
    };

    // iphone 5 - Chrome
    if (infoHeight <= 175 && infoHeight > 165 ){
      $('.my-profile-menu .img-options-display').css('width', '35%');
      $('.my-profile-menu .img-options-display').css('margin-top', '1em');
      $('.my-profile-menu .img-options-display').css('margin-bottom', '1em');
      $('#killed').css('padding-top', '0%');
    };

    // iphone 5 - Safari
    if (infoHeight <= 165 && infoHeight > 125 ){
      $('.my-profile-menu .img-options-display').css('width', '30%');
      $('.my-profile-menu .img-options-display').css('margin-top', '0.6em');
      $('.my-profile-menu .img-options-display').css('margin-bottom', '0.8em');
      $('#killed').css('padding-top', '0%');
    };

    // iphone 4 - all browser
    if (infoHeight <= 125 && infoHeight ){
      $('.my-profile-menu .img-options-display').css('width', '10%');
      $('.my-profile-menu .img-options-display').css('float', 'left');
      $('.my-profile-menu .img-options-display').css('margin-top', '0.1em');
      $('.my-profile-menu .img-options-display').css('margin-bottom', '0.1em');
      $('.my-profile-menu .confirm-action').css('padding', '2px');
      $('#killed').css('padding-top', '0%');
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
