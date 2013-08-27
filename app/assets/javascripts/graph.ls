{first, last, partition, map, tail} = prelude

window.draw_graph = -> 
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

  rates.map ((it) -> new Date(it.date)) |> d3.extent |> x.domain
  rates.map (.value) |> d3.extent |> y.domain

  const month = 1*30*24*60*60*1000

  watermark = (date) ->
    watermark-range = [date - 1*month, date]
    last_month = rates |> partition(-> watermark-range[0] < new Date(it.date) < watermark-range[1]) |> first |> map (.value) >> Number |> d3.extent
    watermark = last_month[0] + (last_month[1] - last_month[0])*0.9 |> y

  watermark-line = d3.svg.line!
    .x (d) -> x (new Date(d.date))
    .y (d) -> watermark (new Date(d.date))
    .interpolate \monotone

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

  svg.append \path
    .data([tail rates])
    .attr {
      class: \watermark
      d: watermark-line
    }

  inverse-watermark = (date) ->
    watermark-range = [date - 1*month, date]
    last_month = rates |> partition(-> watermark-range[0] < new Date(it.date) < watermark-range[1]) |> first |> map (.value) >> Number |> d3.extent
    watermark = last_month[0] + (last_month[1] - last_month[0])*0.1 |> y

  inverse-watermark-line = d3.svg.line!
    .x (d) -> x (new Date(d.date))
    .y (d) -> inverse-watermark (new Date(d.date))
    .interpolate \monotone

  svg.append \path
    .data([tail rates])
    .attr {
      class: \watermark
      d: inverse-watermark-line
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
