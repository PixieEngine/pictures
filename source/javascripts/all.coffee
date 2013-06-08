#= require hamlcoffee
#= require jquery
#= require underscore-min
#= require knockout-2.2.1.debug
#= require bootstrap
#= require cornerstone
#= require namespace
#= require pixie_canvas

#= require_tree ./templates
#= require templater

#= require_tree .

# TODO Data View Class
dataElement = $(JST["templates/data"]())
$("#data").append dataElement
data =
  points: ko.observable 5
  start: ko.observable 20
  radical: ko.observable 150

ko.applyBindings {items: _.pairs(data)}, dataElement.get(0)

# TODO Steps view class
steps = ko.observableArray()
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

# Binding Events
dragBinding = null

$(".steps").on "mouseup touchend", "input", (event) ->
  target = event.currentTarget
  data = ko.dataFor(event.currentTarget)
  value = data.value()

  property = $(target).data("property")
  # TODO
  if dragBinding
    data.bind(property, dragBinding[1])

$("#data").on "mousedown touchstart", ".datum", (event) ->
  data = ko.dataFor(event.currentTarget)

  dragBinding = data

$(document).on "mouseup touchend", ->
  dragBinding = null
