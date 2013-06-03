namespace "Models", (Models) ->
  Models.Circle = (I={}) ->
    I: I

    template: ->
      "description/circle"

    radius: ->
      dx = I.end.x() - I.start.x()
      dy = I.end.y() - I.start.y()

      Math.sqrt(dx * dx + dy * dy)

    perform: (canvas) ->
      canvas.drawCircle
        position: I.start.value()
        radius: @radius()
        color: "black"
