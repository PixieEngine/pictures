#= require hamlcoffee
#= require jquery
#= require "knockout-2.2.1.js"
#= require bootstrap
#= require cornerstone

#= require_tree .

steps = ko.observableArray()

$("#hotkeys").append JST["templates/hotkeys"]()

$("#data").append JST["templates/data"](
  data:
    points: 5
)


canvas = $("canvas").pixieCanvas()

$("canvas").bind
  movestart: (event) ->
    offset = $(event.currentTarget).offset()

    x = event.pageX - offset.left
    y = event.pageY - offset.top

    canvas.drawCircle
      x: x
      y: y
      radius: 10
      color: "green"

  moveend: (event) ->
    offset = $(event.currentTarget).offset()

    x = event.pageX - offset.left
    y = event.pageY - offset.top

    canvas.drawCircle
      x: x
      y: y
      radius: 10
      color: "orange"
