import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
import 'package:webviewx/webviewx.dart';

class WebViewContainer extends StatefulWidget {
  const WebViewContainer({super.key, this.data = "var data = [ ];"});
  final String data;

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant WebViewContainer oldWidget) {
    if (webviewController != null) {
      webviewController!.loadContent(_buildWebviewContent(), SourceType.html);
    }
    super.didUpdateWidget(oldWidget);
  }

  WebViewXController<dynamic>? webviewController;

  String webviewContent = '';

  // @override
  @override
  Widget build(BuildContext context) {
    return WebViewX(
      javascriptMode: JavascriptMode.unrestricted,
      width: double.maxFinite,
      height: 250,
      initialContent: _buildWebviewContent(),
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

  String _buildWebviewContent() {
    return """

<!-- Code from d3-graph-gallery.com -->
<!DOCTYPE html>
<meta charset="utf-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css"
  integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
  integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
  crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
  integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
  crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js"
  integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
  crossorigin="anonymous"></script>
<!-- Load d3.js -->
<script src="https://d3js.org/d3.v4.js"></script>

<!-- Color palette -->
<script src="https://d3js.org/d3-scale-chromatic.v1.min.js"></script>

<!-- Create a div where the graph will take place -->
<div id="my_dataviz"></div>

<style>
  .node:hover {
      stroke-width: 4px !important;
      opacity: 1 !important;
  }


  body {
      cursor: default;
      user-select: none;
      font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;
      font-weight: 200;
      /* // background-color: rgb(255,250,255); */
      background-color: rgb(247, 247, 247);
      padding: 0;
      margin: 0;
      position: absolute;
      width: 100%;
      height: 100%;
      overflow: hidden
  }
</style>


<script>

  // set the dimensions and margins of the graph
  var width = 860
  var height = 460
  var parentWidth = d3.select("body").node().getBoundingClientRect().width;
  var parentHeight = d3.select("body").node().getBoundingClientRect().height;




  var parentWidth = document.body.clientWidth;
  var parentHeight = 460;
  // append the svg object to the body of the page
  var svg = d3.select("#my_dataviz")

      .append("svg")
      // .attr("width", parentWidth)
      // .attr("height", parentHeight)
      .attr("viewBox", `0 0 \${parentWidth} \${parentHeight}`);

  //     var aspect = width / height;
  //     chart = d3.select('.node');
  // d3.select(window)
  //   .on("resize", function() {
  //     var parentHeight = d3.select("body").node().getBoundingClientRect().height;
  // console.log('####');
  // console.log(parentHeight);
  // console.log('####');
  //   });

  ${widget.data}


  // Color palette for continents?
  var color = d3.scaleOrdinal()
      // .domain(["Asia", "Europe", "Africa", "Oceania", "Americas"])
      .range(d3.schemeSet2);

  // Size scale for countries
  var size = d3.scaleLinear()
      .domain([0, 100])
      .range([35, 60])  // circle will be between 7 and 55 px wide

  // create a tooltip
  var Tooltip = d3.select("#my_dataviz")
      .append("div")
      .style("opacity", 0)
      .attr("class", "tooltip")
      .style("color", "white")

      .style("background-color", 'rgba(251, 0, 112, 0.9)')
      .style("opacity", 0.2)
      .style("border", "solid")
      .style("border-width", "0.0px")
      // .style("border-color", "grey")
      .style("border-radius", "5px")
      .style("padding", "5px")

      .style("position", "absolute");


  // Three function that change the tooltip when user hover / move / leave a cell
  var mouseover = function (d) {
      Tooltip
          .style("opacity", 1)
  }
  var mousemove = function (d) {
      Tooltip

          .html('<b>' + d.key + '</b> ' + d.value + "%")
          .style("left", (d3.event.x + 20) + "px") // d3.event.x and d3.event.y give the position of the current event (mouse move)
          .style("top", (d3.event.y) + "px");
      //  .style("background-color", function(d){ return color(d.region)}) 

  }

  var mouseleave = function (d) {
      Tooltip
          .style("opacity", 0)
  }

  var node = svg.append("g")
      .selectAll("g")
      .data(data)
      .enter()

      .append("g")
      .on("mouseover", mouseover) // What to do when hovered
      .on("mousemove", mousemove)
      .on("mouseleave", mouseleave)
      .call(d3.drag() // call specific function when circle is dragged
          .on("start", dragstarted)
          .on("drag", dragged)
          .on("end", dragended));;
  
  // Initialize the circle: all located at the center of the svg area
  node.append("circle")
      .attr("class", "node")
      .attr("id", function (d) { return d.id })
      //  .style("stroke-dasharray", ("8, 3"))
      .attr("r", function (d) { return size(d.value) })
      // .style("fill", function (d) { return d.selected ? "white" : d.positive ? color(d.region) : "#BBB0A9" })
      .style("fill", function (d) { return d.selected ? "white" : d.positive ? "#66c2a5" : "#BBB0A9" })
      .style("fill-opacity", 0.7)
      // .attr("stroke", function (d) { return d.positive ?   color(d.region): "#BBB0A9" })
      .attr("stroke", function (d) { return d.positive ?   "#66c2a5" : "#BBB0A9" })
      .style("stroke-width", 6)
         .style("stroke-dasharray", function (d) { 
      return d.selected ? "8, 4" : ""; 
  });

  // .style("stroke-opacity", 0.2)




  function isTextOutsideCircle(textElement, circleElement) {
      // calculate the bounding boxes of the text and the circle
      var textBBox = textElement.getBBox();
      var circleBBox = circleElement.getBBox();

      // check if the text is outside the circle
      if (textBBox.x < circleBBox.x ||
          textBBox.y < circleBBox.y ||
          textBBox.x + textBBox.width > circleBBox.x + circleBBox.width ||
          textBBox.y + textBBox.height > circleBBox.y + circleBBox.height) {
          return true;
      } else {
          return false;
      }
  }

  node.append("text")
      .text(function (d) { return d.key; }) // display the key
      .style("text-anchor", "middle") // center the text horizontally
      .style("dominant-baseline", "central") // center the text vertically
      .style("font-weight", "normal")
      // .style("letter-spacing", "2px")
      .style("fill", function(d) { return d.selected ?  d3.select(this.parentNode).select("circle").style("stroke") : "#ffffff"}) // set the text color to white
      
      // .style("visibility", function (d) {
          // return isTextOutsideCircle(this, d3.select(this.parentNode).select("circle").node()) ? "hidden" : "visible";
      // });
        .style("visibility", function (d) {
          return d.show_label  ? "visible" : "hidden";
      });
  // .each(function(d) {
  //       // Get the color of the node
  //       var color = d3.select(this.parentNode).select("circle").style("fill");

  //       // Initialize the tooltip
  //       \$(this).tooltip({
  //           title: d.key,
  //           html: true,
  //           container: 'body'
  //       })
  //       .on('show.bs.tooltip', function () {
  //           // When the tooltip is shown, change its background color to match the node
  //           \$('.tooltip').css('background-color', color);
  //           \$('.tooltip').css('border-color', color);
  //       });
  //   });

  // Features of the forces applied to the nodes:
  var simulation = d3
      .forceSimulation()
      .force("y", d3.forceY().y(height / 2)) // Attraction to the center of the svg area
      .force(
          "center",
          d3
              .forceCenter()
              .x(width / 2)
              .y(height / 3.5)
      ) // Attraction to the center of the svg area
      .force("charge", d3.forceManyBody().strength(0.1)) // Nodes are attracted one each other of value is > 0
      .force(
          "collide",
          d3
              .forceCollide()
              .strength(0.2)
              .radius(function (d) {
                  return size(d.value) + 3;
              })
              .iterations(1)
      ); // Force that avoids circle overlapping


       var simulationNegative = d3
      .forceSimulation()
      .force("y", d3.forceY().y(height / 2)) // Attraction to the center of the svg area
      .force(
          "center",
          d3
              .forceCenter()
              .x(width + 50)
              .y(height / 3.5)
      ) // Attraction to the center of the svg area
      .force("charge", d3.forceManyBody().strength(0.1)) // Nodes are attracted one each other of value is > 0
      .force(
          "collide",
          d3
              .forceCollide()
              .strength(0.2)
              .radius(function (d) {
                  return size(d.value) + 3;
              })
              .iterations(1)
      ); // Force that avoid

  // Apply these forces to the nodes and update their positions.
  // Once the force algorithm is happy with positions ('alpha' value is low enough), simulations will stop.
  simulationNegative
      .nodes(data.filter(function (d) { return d.positive === false }))
      .on("tick", function (d) {
          node
              .attr("transform", function (d) { return "translate(" + d.x + "," + d.y + ")" })
      });

       simulation
              .nodes(data.filter(function (d) { return d.positive == true }))
      .on("tick", function (d) {
          node
              .attr("transform", function (d) { "translate(" + d.x + "," + d.y + ")"  })
      });

  // What happens when a circle is dragged?
  function dragstarted(d) {
      if (!d3.event.active) simulation.alphaTarget(.03).restart();
      if (!d3.event.active) simulationNegative.alphaTarget(.03).restart();
      d.fx = d.x;
      d.fy = d.y;
  }
  function dragged(d) {
      d.fx = d3.event.x;
      d.fy = d3.event.y;
  }
  function dragended(d) {
      if (!d3.event.active) simulation.alphaTarget(.03);
      if (!d3.event.active) simulationNegative.alphaTarget(.03);
      d.fx = null;
      d.fy = null;
  }


</script>
""";
  }
}
