namespace "Models", (Models) ->
  Models.Rectangle = (I={}) ->
    I: I
    description: () ->
      "Draw rectangle from #{I.start.x()}, #{I.start.y()} to #{I.end.x()}, #{I.end.y()}"

    perform: (canvas) ->
      canvas.drawRect
        x: I.start.x()
        y: I.start.y()
        width: I.end.x() - I.start.x()
        height: I.end.y() - I.start.y()
        color: "black"
