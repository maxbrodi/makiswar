$( document ).ready(function() {
  // ajustement de la hauteur des divs
  var cellwidth = $('.cell').width();
  $('.cell').css("height", cellwidth);
  $('.worldmap').css("height", cellwidth*5);

  // affichage des autres makis

  $('.cell-info').each(function( index ) {
    var x = $( this ).text().split('-')[1];
    var y = $( this ).text().split('-')[2];
    console.log(x);
    console.log(y);
    console.log(x + y);
    $('*[data-cell="'+ x + y + '"]').addClass("salmon");
//     if ($( this ).is(':empty')){
//     //do something
// }
  });




  // .cell onclick
  //   cell_nb = $(this).data("cell");

  //   $('#cell-info-' + cell_nb)
});
