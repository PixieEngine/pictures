namespace "Models", (Models) ->
  Models.Line = (I={}) ->
    I: I

    template: ->
      "description/line"

    snapPoints: ->
      x0 = parseInt(I.start.x())
      x1 = parseInt(I.end.x())

      y0 = parseInt(I.start.y())
      y1 = parseInt(I.end.y())

      midpoint = Point((x1 + x0) / 2, (y1 + y0) / 2)

      [I.start.value(), midpoint, I.end.value()]

    perform: (canvas) ->
      canvas.drawLine
        start: I.start.value()
        end: I.end.value()
        color: "black"

      for point in @snapPoints()
        canvas.drawCircle
          position: point
          radius: 5
          stroke:
            width: 2
            color: 'white'
          color: '#3685c8'
