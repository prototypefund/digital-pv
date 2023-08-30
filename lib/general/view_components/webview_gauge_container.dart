import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
import 'package:webviewx/webviewx.dart';

class WebGaugeViewContainer extends StatefulWidget {
  const WebGaugeViewContainer({
    super.key,
    this.value = 0,
  });

  final double value;

  @override
  State<WebGaugeViewContainer> createState() => _WebGaugeViewContainerState();
}

class _WebGaugeViewContainerState extends State<WebGaugeViewContainer> {
  late WebViewXController<dynamic> webviewController;
  String webviewContent = '';

  @override
  void initState() {
    webviewContent = '';
    // _loadHtmlFile().then((value) {
    //   webviewController.loadContent(value, SourceType.html);
    // });
    super.initState();
  }

  // Future<String> _loadHtmlFile() async {
  //   return rootBundle.loadString('assets/visualization.html');
  // }

  @override
  Widget build(BuildContext context) {
    return WebViewX(
      javascriptMode: JavascriptMode.unrestricted,
      width: double.maxFinite,
      height: 300,
      initialContent: """

<!DOCTYPE html>
<html>
  <head>
  <style>*{box-sizing:border-box}.gauge-container{font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;display:flex}.gauge g.arc{fill:steelblue}.gauge g.pointer{fill:#F96537;stroke:#F96537; stroke-width:2px; fill-opacity:0.7}.gauge g.label text{text-anchor:middle;font-size:19px;font-weight:700;fill:#666}.gauge .tickline{stroke:"black";stroke-width:1px}.number-div{text-align:center}.number-unit{display:block;font-size:12px}.number-value{font-size:30px}</style>

  </head>
  <body>
   <div class="gauge-container">
      <div id="gauge2"></div>
    </div>
    <script src="https://unpkg.com/d3@5.7.0/dist/d3.min.js"></script>
    <script>
    'use strict';

class Gauge {
  constructor(configuration) {
    // default configuration settings
    const config = {
      size : 400,
      margin : 10,
      minValue : 0,
      maxValue : 10,
      majorTicks : 5,
      lowThreshhold : 3,
      highThreshhold : 7,
      scale: 'linear',
      lowThreshholdColor : '#009900',
      defaultColor : '#ffe500',
      highThreshholdColor : '#cc0000',
      transitionMs : 1000,
      displayUnit: 'Value'
    };

    // define arc shape and position
    this.arcPadding = 15;
    this.arcWidth = 30;
    this.labelInset = 10;

    this.minAngle = -90,
    this.maxAngle = 90,
    this.angleRange = this.maxAngle - this.minAngle;

    this.config = Object.assign(config, configuration);
    this._config();

  }

  _config() {

    // defined pointer shape and size
    const pointerWidth =26;
    const pointerTailLength = 15;
    const pointerHeadLength = this._radius() - this.labelInset;
    this.lineData = [
        [pointerWidth / 2, 0],
        [0, -pointerHeadLength],
        [-(pointerWidth / 2), 0],
        [0, pointerTailLength],
        [pointerWidth / 2, 0]
      ];

    if (this.config.scale == 'log') {
      this.scale = d3.scaleLog()
        .range([0,1])
        .domain([this.config.minValue, this.config.maxValue]);
    }
    else {
      this.scale = d3.scaleLinear()
      .range([0,1])
      .domain([this.config.minValue, this.config.maxValue]);
    }

    const colorDomain = [this.config.lowThreshhold, this.config.highThreshhold].map(this.scale);
    const colorRange  = [
      this.config.lowThreshholdColor,
      this.config.defaultColor,
      this.config.highThreshholdColor
    ];
    this.colorScale = d3.scaleThreshold().domain(colorDomain).range(colorRange);

    let ticks = this.config.majorTicks;
    if (this.config.scale === 'log') {
      ticks = Math.log10(this.config.maxValue/this.config.minValue);
    }
    this.ticks = this.scale.ticks(ticks);

    this.threshholds = [
      this.config.minValue,
      this.config.lowThreshhold,
      this.config.highThreshhold,
      this.config.maxValue
    ]
    .map(d => this.scale(d));

    this.arc = d3.arc()
      .innerRadius(this._radius() - this.arcWidth - this.arcPadding)
      .outerRadius(this._radius() - this.arcPadding)
      .startAngle((d, i) => {
        const ratio = i > 0 ? this.threshholds[i-1] : this.threshholds[0];
        return this._deg2rad(this.minAngle + (ratio * this.angleRange));
      })
      .endAngle((d, i) => this._deg2rad(this.minAngle + this.threshholds[i] * this.angleRange));

  }

  _radius() {

    return (this.config.size - this.config.margin) / 2;

  }

  _deg2rad(deg) {

    return deg * Math.PI / 180;

  }

  setConfig(configuration) {
    this.config = Object.assign(this.config, configuration);
    this._config();
    return this;
  }

  render(container, newValue) {

  // clear gauge if exist
  d3.select(container).selectAll('svg').remove();
  d3.select(container).selectAll('div').remove();

  const svg = d3.select(container)
    .append('svg')
    .attr('class', 'gauge')
    .attr('width', this.config.size + this.config.margin)
    .attr('height', this.config.size / 2 + this.config.margin);

  // display panel arcs with color scale
  const arcs = svg.append('g')
    .attr('class', 'arc')
        .attr("id", "wavy") //Unique id of the path

    .attr('transform', `translate(\${this._radius()}, \${this._radius()})`);




  // draw the color arcs
  arcs.selectAll('path')
    .data(this.threshholds)
    .enter()
    .append('path')
    .attr('fill', d => this.colorScale(d-0.001))
    .attr('d', this.arc);

  // display panel - labels
  const lg = svg.append('g')
    .attr('class', 'label')
    .attr('transform', `translate(\${this._radius()},\${this._radius()})`);

  // // display panel - text
  // lg.selectAll('text')
  //   .data(this.ticks)
  //   .enter()
  //   .append('text')
  //   .attr('transform', d => {
  //      var newAngle = this.minAngle + (this.scale(d) * this.angleRange);
  //      return `rotate(\${newAngle}) translate(0, \${this.labelInset - this._radius()})`;
  //    })
  //   .text(d3.format('1,.0f'));



// add "positiv" label
lg.append('text')
  .attr('transform', `rotate(\${this.minAngle + 40}) translate(0, \${this.labelInset - this._radius()})`)
  .style('text-anchor', 'middle')
  .text('positiv')
  .style('fill', '#A2E5D5');

// add "negativ" label
lg.append('text')
  .attr('transform', `rotate(\${this.maxAngle - 40}) translate(0, \${this.labelInset - this._radius()})`)
  .style('text-anchor', 'middle')
  .text('negativ')
  .style('fill', '#BBB0A9');


  // // display panel - ticks
  // lg.selectAll('line')
  //   .data(this.ticks)
  //   .enter()
  //   .append('line')
  //   .attr('class', 'tickline')
  //   .attr('x1', 0)
  //   .attr('y1', 0)
  //   .attr('x2', 0)
  //   .attr('y2', this.arcWidth + this.labelInset)
  //   .attr('transform', d => {
  //     const newAngle = this.minAngle + (this.scale(d) * this.angleRange);
  //     return `rotate(\${newAngle}), translate(0, \${this.arcWidth  - this.labelInset - this._radius()})`;
  //   })
  //   .style('stroke', '#666')
  //   .style('stroke-width', '1px');

  // display pointer
  const pg = svg.append('g')
    .data([this.lineData])
    .attr('class', 'pointer')
    .attr('transform', `translate(\${this._radius()},\${this._radius()})`);

  const pointer = pg.append('path')
    .attr('d', d3.line())
    .attr('transform', `rotate(\${this.minAngle})`);

  // display current value
  const numberDiv = d3.select(container).append('div')
    .attr('class', 'number-div')
    .style('width', `\${this.config.size - this.config.margin}px`);

  const numberUnit = numberDiv.append('span')
    .attr('class', 'number-unit')
    .text(d => this.config.displayUnit)
    .style('font-size', '24px')
    .style('font-weight', '200')
    .style('font-color', '#666');

  const numberValue = numberDiv.append('span')
    .data([newValue])
    .attr('class', 'number-value')
    .text(d => d === undefined ? 0: d);

  this.pointer = pointer;
  this.numberValue = numberValue;

  }

  update(newValue) {

    const newAngle = this.minAngle + (this.scale(newValue) * this.angleRange);

    this.pointer.transition()
      .duration(this.config.transitionMs)
      .attr('transform', `rotate(\${newAngle})`);

    this.numberValue
      .data([newValue])
      .transition()
      .duration(this.config.transitionMs)
      .style('color', this.colorScale( this.scale(newValue) ))
      //.text(newValue.toFixed(3))
      .tween("", function(d) {
        const interpolator = d3.interpolate( this.textContent, d );
        const that = this;
        return function( t ) {
          that.textContent = interpolator(t).toFixed(1);
        };
      });
  }

}
    </script>
    <script>
    
    'use strict';
/*
   This is for demonstrating the usage of gauge.js, it creates two gauges
   side-by-side with diffent options settings.
*/
document.addEventListener('DOMContentLoaded', () => {


  const powerGauge2 = new Gauge({
    minValue: 0,
    maxValue: 100,
    lowThreshhold: 0,
    highThreshhold: 50,
    lowThreshholdColor: "#A2E5D5",
    defaultColor: "#A2E5D5",
    highThreshholdColor: "#BBB0A9",
    displayUnit: 'Aktuelle Lebensqualität'
  })

  powerGauge2.render("#gauge2");

  // re-configure the gauge panel
  powerGauge2.setConfig({minValue: 0, maxValue:100}).render("#gauge2");

    powerGauge2.update(${widget.value});
});
    </script>
  </body>
</html>
""",
      initialSourceType: SourceType.html,
      onWebViewCreated: (controller) {
        webviewController = controller;

        //     controller.evalRawJavascript( '''
        //   document.body.style.overflow = 'hidden';
        //   document.ontouchmove = function(e){
        //     e.preventDefault();
        //   }
        // ''');
      },
    );
  }
}
