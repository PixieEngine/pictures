namespace "Models", (Models) ->
  Models.Rectangle = (I={}) ->
    color = ko.observable('black')
    strokeColor = ko.observable('black')
    strokeWidth = ko.observable(1)
    rotation = ko.observable(0)

    I: I

    type: 'Rectangle'

    template: ->
      "description/rectangle"

    color: color
    strokeColor: strokeColor
    strokeWidth: strokeWidth
    rotation: rotation

    measurements: ->
      [
        {name: 'width', value: @width()}
        {name: 'height', value: @height()}
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

    width: ->
      I.end.x() - I.start.x()

    height: ->
      I.end.y() - I.start.y()

    center: ->
      x0 = I.start.x()
      y0 = I.start.y()

      arrowHeight = 15

      Point(x0 + (@width() / 2), y0 + (@height() / 2) + arrowHeight)

    snapPoints: ->
      width = @width()
      height = @height()

      x0 = I.start.x()
      x1 = I.end.x()

      y0 = I.start.y()
      y1 = I.end.y()

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
          color: strokeColor()
        width: @width()
        height: @height()
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
