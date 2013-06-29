namespace "Models", (Models) ->
  Models.Line = (I={}) ->
    color = ko.observable('black')
    strokeWidth = ko.observable(1)

    I: I

    template: ->
      "description/line"

    color: color
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

      startX = parseInt(I.start.x())
      endX = parseInt(I.end.x())

      startY = parseInt(I.start.y())
      endY = parseInt(I.end.y())

      f = (someX) ->
        return (endY - startY) / (endX - startX) * (someX - startX) + startY

      Math.abs(f(x) - y) < TOLERANCE &&
      x >= startX &&
      x <= endX

    slope: ->
      x0 = parseInt(I.start.x())
      x1 = parseInt(I.end.x())

      y0 = parseInt(I.start.y())
      y1 = parseInt(I.end.y())

      (y0 - y1) / (x0 - x1)

    length: ->
      x0 = parseInt(I.start.x())
      x1 = parseInt(I.end.x())

      y0 = parseInt(I.start.y())
      y1 = parseInt(I.end.y())

      xComponent = Math.pow(x1 - x0, 2)
      yComponent = Math.pow(y1 - y0, 2)

      return Math.sqrt(xComponent + yComponent)

    center: ->
      midpoint = @midpoint()

      arrowHeight = 15

      Point(midpoint.x, midpoint.y + arrowHeight)

    midpoint: ->
      x0 = parseInt(I.start.x())
      x1 = parseInt(I.end.x())

      y0 = parseInt(I.start.y())
      y1 = parseInt(I.end.y())

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
