$(function() {
  var donutGraph = d3.selectAll(".donut-graph");
  if(donutGraph.length > 0) {
    var width = 240,
        height = 240,
        twoPi = 2 * Math.PI,
        progress = 0,
        formatPercent = d3.format(".0%");

    var arc = d3.svg.arc()
        .startAngle(0)
        .innerRadius(40)
        .outerRadius(50);

    var svg = d3.selectAll(".donut-graph").append("svg")
        .attr("width", width)
        .attr("height", height)
      .append("g")
        .attr("transform", "translate(" + width / 2 + "," + height / 3 + ")");

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
    var i = d3.interpolate(progress, x);
    d3.transition().tween("progress", function() {
      return function(t) {
        progress = i(t);
        foreground.attr("d", arc.endAngle(twoPi * progress));
        text.text(formatPercent(progress));
      };
    });
  }
});
