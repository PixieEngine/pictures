namespace "Models", (Models) ->
  Models.Circle = (I={}) ->
    color = ko.observable('black')
    strokeWidth = ko.observable(1)

    I: I

    template: ->
      "description/circle"

    color: color
    strokeWidth: strokeWidth

    overlaps: (position) ->
      false

    radius: ->
      dx = I.end.x() - I.start.x()
      dy = I.end.y() - I.start.y()

      Math.sqrt(dx * dx + dy * dy)

    snapPoints: ->
      x = parseInt(I.start.x())
      y = parseInt(I.start.y())

      x0 = x - @radius()
      x1 = x + @radius()

      y0 = y - @radius()
      y1 = y + @radius()

      [
        Point(x0, y) # left middle
        Point(x1, y) # right middle
        Point(x, y) # center
        Point(x, y0) # top middle
        Point(x, y1) # bottom middle
      ]

    perform: (canvas, snaps=true) ->
      canvas.drawCircle
        position: I.start.value()
        radius: @radius()
        color: color()
        stroke:
          width: strokeWidth()
          color: 'black'

      if snaps
        for point in @snapPoints()
          canvas.drawCircle
            position: point
            radius: 5
            stroke:
              width: 2
              color: 'white'
            color: '#3685c8'
