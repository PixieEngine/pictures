namespace "Models", (Models) ->
  Models.Rectangle = (I={}) ->
    color = ko.observable('black')
    strokeWidth = ko.observable(1)
    rotation = ko.observable(0)

    I: I

    template: ->
      "description/rectangle"

    color: color
    strokeWidth: strokeWidth
    rotation: 0

    measurements: ->
      [
        {name: 'width', value: I.end.x() - I.start.x()}
        {name: 'height', value: I.end.y() - I.start.y()}
        {name: 'rotation', value: rotation()}
      ]

    overlaps: (position) ->
      x = position.x
      y = position.y

      left = I.start.x()
      right = I.end.x()
      top = I.start.y()
      bottom = I.end.y()

      (left <= x <= right) && (top <= y <= bottom)

    center: ->
      width = I.end.x() - I.start.x()
      height = I.end.y() - I.start.y()

      x0 = parseInt(I.start.x())
      y0 = parseInt(I.start.y())

      arrowHeight = 15

      Point(x0 + (width / 2), y0 + (height / 2) + arrowHeight)

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
        stroke:
          width: strokeWidth()
          color: 'black'
        width: I.end.x() - I.start.x()
        height: I.end.y() - I.start.y()
        color: color()

      if snaps
        for point in @snapPoints()
          canvas.drawCircle
            position: point
            radius: 5
            stroke:
              width: 2
              color: 'white'
            color: '#3685c8'
