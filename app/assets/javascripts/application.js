//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require pubsub-js

//= require_tree ./app


// Please do not put any code in here. Create a new .js file in
// app/assets/javascripts/app instead, and put your code there

var windowHeight = $(window).innerHeight()
$('.makiswar-not-connected').css("height", windowHeight);
$('.makiswar-devise').css("height", windowHeight);
$('.makiswar-devise .card-bg-1').css("height", windowHeight);
