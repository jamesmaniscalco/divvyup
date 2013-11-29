window.Charts ||= {};

Charts.pieChart = (data, divTitle, amountField, labelField) ->
  width = $("#" + divTitle).width()
  height = width
  radius = Math.round(width / 2)

  color = d3.scale.category20c()
  vis = d3.select("#" + divTitle).append("svg:svg").data([data]).attr("width", width).attr("height", height).attr("viewBox", "0 0 " + (width+1) + " " + (height+1)).attr("preserveAspectRatio", "xMinYMid").append("svg:g").attr("transform", "translate(" + radius + " " + radius + ")")
  arc = d3.svg.arc().outerRadius(radius)
  pie = d3.layout.pie().value((d) ->
    d[amountField]
  )
  arcs = vis.selectAll("g.slice").data(pie).enter().append("svg:g").attr("class", "slice")
  arcs.append("svg:path").attr("fill", (d, i) ->
    color i
  ).attr("d", arc);

  arcs.append("svg:text")
   .attr("transform", (d) ->
    d.innerRadius = 0
    d.outerRadius = radius
    "translate(" + arc.centroid(d) + ")"
  ).attr("font-size", Math.round(width / 15) + "px"
  ).attr("text-anchor", "middle").text (d, i) ->
    data[i][labelField]
    
Charts.resize = () ->
  $(window).on("resize", ->
      chart = $("svg")
      aspect = chart.width() / chart.height()
      container = chart.parent()
  
      targetWidth = container.width()
      chart.attr("width", targetWidth)
      chart.attr("height", Math.round(targetWidth / aspect))
    ).trigger("resize")
