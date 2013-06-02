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

canvas = $("canvas#lower").pixieCanvas()
upperCanvas = $("canvas#upper").pixieCanvas()

start = null

localPosition = (event) ->
  offset = $(event.currentTarget).offset()

  x: event.pageX - offset.left
  y: event.pageY - offset.top

$("canvas").bind
  "touchstart mousedown": (event) ->
    start = localPosition(event)

  "touchmove mousemove": (event) ->
    return unless start

    upperCanvas.clear()
    upperCanvas.drawLine
      start: start
      end: localPosition(event)

  "touchend mouseup": (event) ->
    step = Step
      start: start
      end: localPosition(event)

    step.perform(canvas)

    steps.push step

    start = null
