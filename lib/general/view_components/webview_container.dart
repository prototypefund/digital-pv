import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
import 'package:webviewx/webviewx.dart';
import 'package:collection/collection.dart';

class WebViewContainer extends StatefulWidget {
  const WebViewContainer({super.key, this.data = "var data = [ ];"});
  final String data;

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  String? _oldData;

  Function deepEq = const DeepCollectionEquality.unordered().equals;

  @override
  void didUpdateWidget(covariant WebViewContainer oldWidget) {
    if (webviewController != null) {
      // ignore: avoid_dynamic_calls
      if (widget.data.isNotEmpty && _oldData != null && deepEq(widget.data, _oldData) == false) {
        webviewController!.loadContent(_buildWebviewContent(), SourceType.html);
      }
      _oldData = widget.data;
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

<!-- Code inspired from d3-graph-gallery.com -->
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
<script src="https://d3js.org/d3.v4.js"></script>

<script src="https://d3js.org/d3-scale-chromatic.v1.min.js"></script>

<div id="my_dataviz"></div>

<style>
    .node:hover {
        stroke-width: 4px !important;
        opacity: 1 !important;
    }

    body {
        cursor: default;
        user-select: none;
        font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
        font-weight: 200;
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

    var width = 860;
    var height = 250;
    var parentWidth = d3.select("body").node().getBoundingClientRect().width;
    var parentHeight = d3.select("body").node().getBoundingClientRect().height;

    var parentWidth = document.body.clientWidth;
    var parentHeight = 250;
    var svg = d3.select("#my_dataviz")
        .append("svg")
        .attr("viewBox", `0 0 \${parentWidth} \${parentHeight}`);

  ${widget.data}


    var color = d3.scaleOrdinal()
        .range(d3.schemeSet2);

    var size = d3.scaleLinear()
        .domain([0, 100])
        .range([35, 60])  // circle will be between 7 and 55 px wide

    var Tooltip = d3.select("#my_dataviz")
        .append("div")
        .style("opacity", 0)
        .attr("class", "tooltip")
        .style("color", "white")
        .style("background-color", 'rgba(251, 0, 112, 0.9)')
        .style("opacity", 0.2)
        .style("border", "solid")
        .style("border-width", "0.0px")
        .style("border-radius", "5px")
        .style("padding", "5px")
        .style("position", "absolute");


    var mouseover = function (d) {
        Tooltip
            .style("opacity", 1)
    }
    var mousemove = function (d) {
        Tooltip

            .html('<b>' + d.key + '</b> ' + d.value + "%")
            .style("left", (d3.event.x + 20) + "px") // d3.event.x and d3.event.y give the position of the current event (mouse move)
            .style("top", (d3.event.y) + "px");
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

    node.append("circle")
        .attr("class", "node")
        .attr("id", function (d) { return d.id })
        .attr("r", function (d) { return size(d.value) })
        .style("fill", function (d) { return d.selected ? "white" : d.positive ? "#66c2a5" : "#BBB0A9" })
        .style("fill-opacity", 0.7)
        .attr("stroke", function (d) { return d.positive ? "#66c2a5" : "#BBB0A9" })
        .style("stroke-width", 6)
        .style("stroke-dasharray", function (d) {
            return d.selected ? "8, 4" : "";
        });



    node.append("text")
        .text(function (d) { return d.key; }) // display the key
        .style("text-anchor", "middle") // center the text horizontally
        .style("dominant-baseline", "central") // center the text vertically
        .style("font-weight", "normal")
        .style("fill", function (d) { return d.selected ? d3.select(this.parentNode).select("circle").style("stroke") : "#ffffff" }) // set the text color to white

        .style("visibility", function (d) {
            return d.show_label ? "visible" : "hidden";
        });

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
                .attr("transform", function (d) { "translate(" + d.x + "," + d.y + ")" })
        });

    function dragstarted(d) {
        if (!d3.event.active) simulation.alphaTarget(.03).restart();
        if (!d3.event.active) simulationNegative.alphaTarget(.03).restart();
        d.fx = d.x;
        d.fy = d.y;
    }
    function dragged(d) {
        var radius = size(d.value) + 5; // 5 stroke width
        d.fx = Math.max(radius, Math.min(width - radius, d3.event.x));
        d.fy = Math.max(radius, Math.min(height - radius, d3.event.y));
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
