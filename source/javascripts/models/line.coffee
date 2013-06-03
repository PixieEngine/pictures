namespace "Models", (Models) ->
  Models.Line = (I={}) ->
    I: I

    description: () ->
      "Draw line from #{I.start.x()}, #{I.start.y()} to #{I.end.x()}, #{I.end.y()}"

    perform: (canvas) ->
      canvas.drawLine
        start: I.start.value()
        end: I.end.value()
        color: "black"
