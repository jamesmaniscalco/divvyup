# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



window.ItemType ||= {};

ItemType.show = () ->
#   width = $("#usage-pie").width()
#   height = width
#   radius = Math.round(width / 2)
# 
#   color = d3.scale.category20c()
#   vis = d3.select("#usage-pie").append("svg:svg").data([usage_data]).attr("width", width).attr("height", height).attr("viewBox", "0 0 " + (width+1) + " " + (height+1)).attr("preserveAspectRatio", "xMinYMid").append("svg:g").attr("transform", "translate(" + radius + " " + radius + ")")
#   arc = d3.svg.arc().outerRadius(radius)
#   pie = d3.layout.pie().value((d) ->
#     d.amount_used
#   )
#   arcs = vis.selectAll("g.slice").data(pie).enter().append("svg:g").attr("class", "slice")
#   arcs.append("svg:path").attr("fill", (d, i) ->
#     color i
#   ).attr("d", arc);
# 
#   arcs.append("svg:text")
#    .attr("transform", (d) ->
#     d.innerRadius = 0
#     d.outerRadius = radius
#     "translate(" + arc.centroid(d) + ")"
#   ).attr("font-size", Math.round(width / 15) + "px"
#   ).attr("text-anchor", "middle").text (d, i) ->
#     usage_data[i].person_name
  Charts.pieChart(usage_data, "usage-pie", "amount_used", "person_name");
  Charts.pieChart(purchase_data, "purchase-pie", "amount_purchased", "person_name");

$(window).on("resize", ->
    chart = $("svg")
    aspect = chart.width() / chart.height()
    container = chart.parent()

    targetWidth = container.width()
    chart.attr("width", targetWidth)
    chart.attr("height", Math.round(targetWidth / aspect))
  ).trigger("resize")
