#= require hamlcoffee
#= require jquery
#= require jquery.event.move
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
  points: 5
  start: 20
  radical: 150
  x: [22, 44, 67, 82, 110]
  y: [122, 39, 27, 202, 70]
  width: [4, 4, 7, 5, 4]

ko.applyBindings Models.Data(data), dataElement.get(0)

# TODO Steps view class
steps = ko.observableArray()
stepsElement = $(JST["templates/steps"]())
$("#steps").append stepsElement
ko.applyBindings {steps: steps}, stepsElement.get(0)

window.refreshCanvas = ->
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

# don't draw unless we have moved a minimal distance.
# Prevents drawing nearly invisible points
startPoint = null
MOVEMENT_THRESHOLD = 1

$("canvas").bind
  "touchstart mousedown": (event) ->
    activeStep = activeTool
      start: Observable.Point localPosition(event)
      end: Observable.Point localPosition(event)

    startPoint = localPosition(event)

    steps.push activeStep

  "touchmove mousemove": (event) ->
    return unless activeStep

    upperCanvas.clear()

    activeStep.I.end.set(localPosition(event))

    activeStep.perform(upperCanvas)

  "touchend mouseup": (event) ->
    currentPoint = localPosition(event)

    dx = currentPoint.x - startPoint.x
    dy = currentPoint.y - startPoint.y

    magnitude = Math.sqrt(Math.pow(dx, 2) + Math.pow(dy, 2))

    # only draw the shape if the mouse has moved
    # far enough, otherwise pull it off the steps array
    if magnitude > MOVEMENT_THRESHOLD
      activeStep.perform(canvas)
    else
      steps.pop()

    startPoint = null
    activeStep = null

# Binding Events
dragBinding = null

$(".steps").on "mouseup touchend", "input", (event) ->
  target = event.currentTarget
  data = ko.dataFor(event.currentTarget)
  value = data.value()

  property = $(target).data("property")

  if dragBinding
    # TODO Array magic
    data.bind(property, dragBinding.value()[0].n)

$(document).on "move", ".adjustable", (event) ->
  target = event.currentTarget

  data = ko.dataFor(event.currentTarget)

  if property = $(target).data('property')
    data[property](event.distX)
  else
    data(event.distX)

$("#data").on "mousedown touchstart", ".datum", (event) ->
  data = ko.dataFor(event.currentTarget)

  dragBinding = data

$(document).on "mouseup touchend", ->
  dragBinding = null
