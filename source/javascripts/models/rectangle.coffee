namespace "Models", (Models) ->
  Models.Rectangle = (I={}) ->
    I: I

    template: ->
      "description/rectangle"

    snapPoints: ->
      width = I.end.x() - I.start.x()
      height = I.end.y() - I.start.y()

      x0 = parseInt(I.start.x())
      x1 = parseInt(I.end.x())

      y0 = parseInt(I.start.y())
      y1 = parseInt(I.end.y())

      [
        Point(x0, y0) # top left
        Point(x0 + (width / 2), y0) # top middle
        Point(x1, y0) # top right
        Point(x0, y0 + (height / 2)) # middle left
        Point(x0 + (width / 2), y0 + (height / 2))
        Point(x1, y0 + (height / 2)) # middle right
        Point(x0, y1) # bottom left
        Point(x0 + (width / 2), y1) # bottom center
        Point(x1, y1) # bottom right
      ]

    perform: (canvas, snaps=true) ->
      canvas.drawRect
        x: I.start.x()
        y: I.start.y()
        width: I.end.x() - I.start.x()
        height: I.end.y() - I.start.y()
        color: "black"

      if snaps
        for point in @snapPoints()
          canvas.drawCircle
            position: point
            radius: 5
            stroke:
              width: 2
              color: 'white'
            color: '#3685c8'
