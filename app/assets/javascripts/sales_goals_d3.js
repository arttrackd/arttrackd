$(function() {
  var donutGraph = d3.select("#donut-graph");
  if(donutGraph.length > 0) {
    var width = 960,
        height = 500,
        twoPi = 2 * Math.PI,
        progress = 0,
        //total = 1308573, // must be hard-coded if server doesn't report Content-Length
        formatPercent = d3.format(".0%");

    var arc = d3.svg.arc()
        .startAngle(0)
        .innerRadius(90)
        .outerRadius(120);

    var svg = d3.select("#donut-graph").append("svg")
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


    var x = donutGraph.attr("data-percentage");
    var i = d3.interpolate(progress,  x / 1);
    d3.transition().tween("progress", function() {
      return function(t) {
        progress = i(t);
        foreground.attr("d", arc.endAngle(twoPi * progress));
        text.text(formatPercent(progress));
      };
    });
  }
});
