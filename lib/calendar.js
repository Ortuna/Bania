var jsdom   = require('jsdom'),
    tmp     = require('temp'),
    svg2png = require('svg2png'),
    fs      = require('fs');

var Calendar = function() {
  
  var context = this;

  this.generate = function() {
    context.svgTemp = tmp.path({suffix: '.svg'});
    context.pngTemp = tmp.path({suffix: '.png'});

    return context._generateSVG();
  };


  this._cleanup = function() {
    //fs.unlink(context.svgTemp);
  };

  this._generateSVG = function() {
    jsdom.env(
      "<html><body></body></html>",
      [ 'http://d3js.org/d3.v3.min.js' ],
      function (err, window) {
        var svg = window.d3.select("body")
            .append("svg")
            .attr("width", 100).attr("height", 100);

        svg.append("rect")
            .attr("x", 10)
            .attr("y", 10)
            .attr("width", 80)
            .attr("height", 80)
            .style("fill", "orange");

        svg = window.d3.select("body").html();

        fs.writeFileSync(context.svgTemp, svg);

        return context.svgTemp;
      }
    );
  };

  return this;
};

module.exports = Calendar;
