prelude.installPrelude window

w = 800
h = 500

svg = d3.select \svg
  .attr viewBox: "0 0 #w #h"

x = d3.scale.linear!.range [50, 750]
y = d3.scale.linear!.range [450, 50]

line = d3.svg.line!
  .x (d) -> x (new Date(d.date))
  .y (d) -> y d.value

rates <- d3.json "#{document.location}.json"

rates |> map ((it) -> new Date(it.date)) |> d3.extent |> x.domain
rates |> map (.value) |> d3.extent |> y.domain

svg.selectAll '.rule'
  .data y.ticks 10
.enter!.append \line
  .attr {
    class: \rule
    x1: x.range![0]
    x2: x.range![1]
    y1: y
    y2: y
  }

svg.append(\path)
  .data([rates])
  .attr {
    class: \graph
    d: line
  }

yaxis = d3.svg.axis!
  .scale y
  .orient \right

svg.append \g
  .attr {
    class: \axis
    transform: "translate(750, 0)"
  }
  .call yaxis
