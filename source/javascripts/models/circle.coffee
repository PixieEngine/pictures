namespace "Models", (Models) ->
  Models.Circle = (I={}) ->
    color = ko.observable('black')
    strokeColor = ko.observable('black')
    strokeWidth = ko.observable(1)

    I: I

    type: 'Circle'

    template: ->
      "description/circle"

    color: color
    strokeColor: strokeColor
    strokeWidth: strokeWidth

    # here, position is the center point
    moveTo: (position) ->
      xDiff = position.x - I.start.x()
      yDiff = position.y - I.start.y()

      # start by moving the start point
      I.start.x(position.x)
      I.start.y(position.y)

      # make sure to move the end the same amount
      I.end.x(I.end.x() + xDiff)
      I.end.y(I.end.y() + yDiff)

    overlaps: (position) ->
      x = position.x
      y = position.y

      centerX = I.start.x()
      centerY = I.start.y()

      Math.pow(x - centerX, 2) + Math.pow(y - centerY, 2) <= Math.pow(@radius(), 2)

    center: ->
      x = I.start.x()
      y = I.start.y()

      arrowHeight = 15

      Point(x, y + arrowHeight)

    measurements: ->
      [
        {name: 'radius', value: @radius()}
      ]

    radius: ->
      dx = I.end.x() - I.start.x()
      dy = I.end.y() - I.start.y()

      Math.sqrt(dx * dx + dy * dy)

    snapPoints: ->
      x = I.start.x()
      y = I.start.y()

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
          color: strokeColor()

      if snaps
        for point in @snapPoints()
          canvas.drawCircle
            position: point
            radius: 5
            stroke:
              width: 2
              color: 'white'
            color: '#3685c8'
