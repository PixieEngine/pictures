#= require hamlcoffee
#= require jquery
#= require "knockout-2.2.1.js"
#= require bootstrap
#= require cornerstone
#= require namespace

#= require_tree .

steps = ko.observableArray()

$("#hotkeys").append JST["templates/hotkeys"]()

$("#data").append JST["templates/data"](
  data:
    points: 5
)

stepsElement = $(JST["templates/steps"]())
$("#steps").append stepsElement
ko.applyBindings {steps: steps}, stepsElement.get(0)

canvas = $("canvas#lower").pixieCanvas()
upperCanvas = $("canvas#upper").pixieCanvas()

localPosition = (event) ->
  offset = $(event.currentTarget).offset()

  x: event.pageX - offset.left
  y: event.pageY - offset.top

activeStep = null

$("canvas").bind
  "touchstart mousedown": (event) ->
    activeStep = Models.Rectangle
      start: Observable.Point localPosition(event)
      end: Observable.Point localPosition(event)

  "touchmove mousemove": (event) ->
    return unless activeStep

    upperCanvas.clear()

    activeStep.I.end.set(localPosition(event))

    activeStep.perform(upperCanvas)

  "touchend mouseup": (event) ->
    activeStep.perform(canvas)
    steps.push activeStep

    activeStep = null
