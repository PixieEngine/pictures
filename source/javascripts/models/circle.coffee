namespace "Models", (Models) ->
  Models.Circle = (I={}) ->
    I: I

    template: ->
      "description/circle"

    radius: ->
      dx = I.end.x() - I.start.x()
      dy = I.end.y() - I.start.y()

      Math.sqrt(dx * dx + dy * dy)

    magnetPoints: ->
      centerX = I.start.x()
      centerY = I.start.y()

      x0 = I.start.x() - @radius()
      x1 = I.start.x() + @radius()

      y0 = I.start.y() - @radius()
      y1 = I.start.y() + @radius()

      [
        Point(x0, centerY) # left middle
        Point(x1, centerY) # right middle
        Point(centerX, y0) # top middle
        Point(centerX, y1) # bottom middle
      ]

    perform: (canvas) ->
      canvas.drawCircle
        position: I.start.value()
        radius: @radius()
        color: "black"
