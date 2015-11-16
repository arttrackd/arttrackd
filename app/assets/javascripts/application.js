// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require d3


function cloneMaterialFields(){
  var fields = $(".material-fields");
  fields.last().show();
  fields.last().clone(fields).last().appendTo('.material-form').hide();
  changeUnits(".material-fields > div > input");
  changeMaterial(".material-fields > div > select");
}


function changeUnits(selector){
  number = $(selector).slice(-5)[0].name.match(/\d/)
  number = parseInt(number) + 1

  for (var i = 0; i < $(selector).slice(-3).length; i++){
    $(selector).slice(-3)[i].name = $(selector).slice(-3)[i].name.replace(/\d/, number)
    $(selector).slice(-3)[i].id = $(selector).slice(-3)[i].id.replace(/\d/, number)
  }
}

function changeMaterial(selector){
  count = $(selector)[0].name.match(/\d/)
  count = parseInt(count) + 1

  for (var i = 0; i < $(selector).length; i++){
    $(selector)[i].name = $(selector)[i].name.replace(/\d/, count)
    $(selector)[i].id = $(selector)[i].id.replace(/\d/, count)
  }
}


$(document).ready(function () {
  $(".add-material-button").on("click", cloneMaterialFields);
  $(".material-fields").last().hide();
  $(".sidebar-column").height($(document).height());

  $('.accordion-tabs-minimal').each(function(index) {
    $(this).children('li').first().children('a').addClass('is-active').next().addClass('is-open').show();
  });
  $('.accordion-tabs-minimal').on('click', 'li > a.tab-link', function(event) {
    if (!$(this).hasClass('is-active')) {
      event.preventDefault();
      var accordionTabs = $(this).closest('.accordion-tabs-minimal');
      accordionTabs.find('.is-open').removeClass('is-open').hide();

      $(this).next().toggleClass('is-open').toggle();
      accordionTabs.find('.is-active').removeClass('is-active');
      $(this).addClass('is-active');
    } else {
      event.preventDefault();
    }
  });
  var menuToggle = $('#js-mobile-menu').unbind();
  $('#js-navigation-menu').removeClass("show");

  menuToggle.on('click', function(e) {
    e.preventDefault();
    $('#js-navigation-menu').slideToggle(function(){
      if($('#js-navigation-menu').is(':hidden')) {
        $('#js-navigation-menu').removeAttr('style');
      }
    });

    if ($("#js-parallax-window").length) {
      parallax();
    }
  });

  $(window).scroll(function(e) {
    if ($("#js-parallax-window").length) {
      parallax();
    }
  });

  function parallax(){
    if( $("#js-parallax-window").length > 0 ) {
      var plxBackground = $("#js-parallax-background");
      var plxWindow = $("#js-parallax-window");

      var plxWindowTopToPageTop = $(plxWindow).offset().top;
      var windowTopToPageTop = $(window).scrollTop();
      var plxWindowTopToWindowTop = plxWindowTopToPageTop - windowTopToPageTop;

      var plxBackgroundTopToPageTop = $(plxBackground).offset().top;
      var windowInnerHeight = window.innerHeight;
      var plxBackgroundTopToWindowTop = plxBackgroundTopToPageTop - windowTopToPageTop;
      var plxBackgroundTopToWindowBottom = windowInnerHeight - plxBackgroundTopToWindowTop;
      var plxSpeed = 0.35;

      plxBackground.css('top', - (plxWindowTopToWindowTop * plxSpeed) + 'px');
    }
  }
});
