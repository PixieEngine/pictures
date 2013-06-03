#= require hamlcoffee
#= require jquery
#= require knockout-2.2.1.debug
#= require bootstrap
#= require cornerstone
#= require namespace

#= require_tree ./templates
#= require templater

#= require_tree .

steps = ko.observableArray()

$("#data").append JST["templates/data"](
  data:
    points: 5
)

stepsElement = $(JST["templates/steps"]())
$("#steps").append stepsElement
ko.applyBindings {steps: steps}, stepsElement.get(0)

# Redraw Canvas
$(document).on "blur", "input", ->
  canvas.clear()

  steps().forEach (step) ->
    step.perform(canvas)

canvas = $("canvas#lower").pixieCanvas()
upperCanvas = $("canvas#upper").pixieCanvas()

localPosition = (event) ->
  offset = $(event.currentTarget).offset()

  x: event.pageX - offset.left
  y: event.pageY - offset.top

activeStep = null

$("canvas").bind
  "touchstart mousedown": (event) ->
    activeStep = activeTool
      start: Observable.Point localPosition(event)
      end: Observable.Point localPosition(event)

    steps.push activeStep

  "touchmove mousemove": (event) ->
    return unless activeStep

    upperCanvas.clear()

    activeStep.I.end.set(localPosition(event))

    activeStep.perform(upperCanvas)

  "touchend mouseup": (event) ->
    activeStep.perform(canvas)
    upperCanvas.clear()

    activeStep = null
