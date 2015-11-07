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

$(document).ready(function () {
  start();
  $(".dashboard-projects-column").height($(document).height());

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
  });

  var width = 960,
      height = 500,
      twoPi = 2 * Math.PI,
      progress = 0,
      total = 1308573, // must be hard-coded if server doesn't report Content-Length
      formatPercent = d3.format(".0%");

  var arc = d3.svg.arc()
      .startAngle(0)
      .innerRadius(180)
      .outerRadius(240);

  var svg = d3.select("body").append("svg")
      .attr("width", width)
      .attr("height", height)
      .append("g")
      .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

  var meter = svg.append("g")
      .attr("class", "progress-meter");

  meter.append("path")
      .attr("class", "background")
      .attr("d", arc.endAngle(twoPi));

  var foreground = meter.append("path")
      .attr("class", "foreground");

  var text = meter.append("text")
      .attr("text-anchor", "middle")
      .attr("dy", ".35em");

  d3.json("https://api.github.com/repos/mbostock/d3/git/blobs/2e0e3b6305fa10c1a89d1dfd6478b1fe7bc19c1e?" + Math.random())
      .on("progress", function() {
        var i = d3.interpolate(progress, .3 / 1);
        d3.transition().tween("progress", function() {
          return function(t) {
            progress = i(t);
            foreground.attr("d", arc.endAngle(twoPi * progress));
            text.text(formatPercent(progress));
          };
        });
      })
      .get(function(error, data) {
        meter.transition().delay(250);
      });
});


// D3 Stuff
//

// function draw(data) {
//     var color = d3.scale.category20b();
//     var width = 420,
//         barHeight = 20;
//
//     var x = d3.scale.linear()
//         .range([0, width])
//         .domain([0, d3.max(data)]);
//
//     var chart = d3.select("#graph")
//         .attr("width", width)
//         .attr("height", barHeight * data.length);
//
//     var bar = chart.selectAll("g")
//         .data(data)
//         .enter().append("g")
//         .attr("transform", function (d, i) {
//                   return "translate(0," + i * barHeight + ")";
//               });
//
//     bar.append("rect")
//         .attr("width", x)
//         .attr("height", barHeight - 1)
//         .style("fill", function (d) {
//                    return color(d)
//                })
//
//     bar.append("text")
//         .attr("x", function (d) {
//                   return x(d) - 10;
//               })
//         .attr("y", barHeight / 2)
//         .attr("dy", ".35em")
//         .style("fill", "white")
//         .text(function (d) {
//                   return d;
//               });
// }
//
// function error() {
//     console.log("error")
// }
