namespace "Models", (Models) ->
  Models.Rectangle = (I={}) ->
    I: I

    template: ->
      "description/rectangle"

    magnetPoints: ->
      width = I.end.x() - I.start.x()
      height = I.end.y() - I.start.y()

      x0 = I.start.x()
      x1 = I.end.x()

      y0 = I.start.y()
      y1 = I.end.y()

      [
        Point(x0, y0) # top left
        Point(x0 + (width / 2), y0) # top middle
        Point(x1, y0) # top right
        Point(x0, y0 + (height / 2)) # middle left
        Point(x1, y0 + (height / 2)) # middle right
        Point(x0, y1) # bottom left
        Point(x0 + (width / 2), y1) # bottom center
        Point(x1, y1) # bottom right
      ]

    perform: (canvas) ->
      canvas.drawRect
        x: I.start.x()
        y: I.start.y()
        width: I.end.x() - I.start.x()
        height: I.end.y() - I.start.y()
        color: "black"
