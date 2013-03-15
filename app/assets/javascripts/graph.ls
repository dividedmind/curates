prelude.installPrelude window

w = 800
h = 600

svg = d3.select \svg
  .attr(\viewBox, "0 0 #w #h")
  .attr(\preserveAspectRatio, \none)

x = d3.scale.linear!.range [50, 750]
y = d3.scale.linear!.range [550, 50]

line = d3.svg.line!
  .x (d) -> x (new Date(d.date))
  .y (d) -> y d.value

rates <- d3.json "#{document.location}.json"

rates |> map ((it) -> new Date(it.date)) |> d3.extent |> x.domain
rates |> map (.value) |> d3.extent |> y.domain

svg.append(\path).data([rates]).attr \d, (d) -> console.log d; line(d)

window.rates = rates
window.x = x
window.y = y
