//Donut
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

$.ajax({
  type: "GET",
  contentType: "application/json; charset=utf-8",
  url: '/sales_channels/get_data',
  dataType: 'json',
  data: "{}",
  success: function (received_data) {
    draw_pie(received_data);
  },
  error: function (result) {
  }
});
//Pie
function draw_pie(data_to_draw){
  var pieChart = d3.selectAll("#pieChart");
  var stuff = pieChart.pieData;

  var pie = new d3pie("pieChart", {
    "size": {
      "canvasHeight": 150,
      "canvasWidth": 300,
      "pieOuterRadius": "75%"
    },
    "data": {
      "sortOrder": "value-desc",
      "content": data_to_draw
    },
    "labels": {
      "outer": {
        "pieDistance": 10
      },
      "mainLabel": {
        "fontSize": 11
      },
      "percentage": {
        "color": "#ffffff",
        "decimalPlaces": 0
      },
      "value": {
        "color": "#adadad",
        "fontSize": 11
      },
      "lines": {
        "enabled": true
      },
      "truncation": {
        "enabled": true
      }
    },
    "effects": {
      "pullOutSegmentOnClick": {
        "effect": "linear",
        "speed": 400,
        "size": 8
      }
    },
    "misc": {
      "gradient": {
        "enabled": false,
        "percentage": 100
      }
    }
  });
}
