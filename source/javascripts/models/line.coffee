namespace "Models", (Models) ->
  Models.Line = (I={}) ->
    color = ko.observable('black')
    strokeColor = ko.observable('black')
    strokeWidth = ko.observable(1)

    I: I

    type: 'Line'

    template: ->
      "description/line"

    color: color
    strokeColor: strokeColor
    strokeWidth: strokeWidth

    measurements: ->
      [
        {name: "Length", value: @length()}
        {name: "Slope", value: @slope()}
      ]

    overlaps: (position) ->
      TOLERANCE = 5

      x = position.x
      y = position.y

      startX = I.start.x()
      endX = I.end.x()

      startY = I.start.y()
      endY = I.end.y()

      f = (someX) ->
        return (endY - startY) / (endX - startX) * (someX - startX) + startY

      Math.abs(f(x) - y) < TOLERANCE &&
      x >= startX &&
      x <= endX

    slope: ->
      x0 = I.start.x()
      x1 = I.end.x()

      y0 = I.start.y()
      y1 = I.end.y()

      (y0 - y1) / (x0 - x1)

    length: ->
      x0 = I.start.x()
      x1 = I.end.x()

      y0 = I.start.y()
      y1 = I.end.y()

      xComponent = Math.pow(x1 - x0, 2)
      yComponent = Math.pow(y1 - y0, 2)

      return Math.sqrt(xComponent + yComponent)

    center: ->
      midpoint = @midpoint()

      arrowHeight = 15

      Point(midpoint.x, midpoint.y + arrowHeight)

    midpoint: ->
      x0 = I.start.x()
      x1 = I.end.x()

      y0 = I.start.y()
      y1 = I.end.y()

      Point((x1 + x0) / 2, (y1 + y0) / 2)

    snapPoints: ->
      [I.start.value(), @midpoint(), I.end.value()]

    perform: (canvas, options={}) ->
      {snaps, n} = options

      canvas.drawLine
        start: I.start.value(n)
        end: I.end.value(n)
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
