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

steps = Models.Steps()
stepsElement = $(JST["templates/steps"]())
$("#steps").append stepsElement
ko.applyBindings steps, stepsElement.get(0)

menu = Models.Menu()
menuElement = $(JST["templates/menu"]())
$("#menu").append menuElement
ko.applyBindings menu, menuElement.get(0)

mainDescriptionElement = $(JST["templates/main_description"]())
$("#main .description:eq(0)").append mainDescriptionElement
ko.applyBindings steps, mainDescriptionElement.get(0)

window.refreshCanvas = (snaps=true) ->
  canvas.clear()
  steps.draw(canvas, snaps)

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
    position = localPosition(event)

    activeStep = activeTool
      start: Observable.Point position
      end: Observable.Point position

    startPoint = position

    steps.push activeStep

    # don't try and draw a shape if
    # the context menu is triggered
    if event.altKey
      steps.at(position).compact().each (step) ->
        menu.show(step)

        steps.pop()
    else
      menu.hide()

  "touchmove mousemove": (event) ->
    return unless activeStep

    activeStep.I.end.set(localPosition(event))

  "touchend mouseup": (event) ->
    currentPoint = localPosition(event)

    dx = currentPoint.x - startPoint.x
    dy = currentPoint.y - startPoint.y

    magnitude = Math.sqrt(Math.pow(dx, 2) + Math.pow(dy, 2))

    # only draw the shape if the mouse has moved
    # far enough, otherwise pull it off the steps array
    # if magnitude <= MOVEMENT_THRESHOLD
    #   steps.pop()

    activeStep = null
    startPoint = null

$(".steps").on "mouseup touchend", ".step", (event) ->
  data = ko.dataFor(event.currentTarget)

  steps.active(data)
  refreshCanvas()

# Binding Events
dragBinding = null

$(".steps").on "mouseup touchend", ".bindy", (event) ->
  target = event.currentTarget
  data = ko.dataFor(event.currentTarget)
  value = data.value()

  property = $(target).data("property")

  if dragBinding
    # TODO: Consider binding on steps rather than on points
    data.bind(property, dragBinding)

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
