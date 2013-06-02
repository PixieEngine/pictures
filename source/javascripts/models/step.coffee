Step = (I={}) ->
  description: () ->
    "Draw line from #{I.start.x}, #{I.start.y} to #{I.end.x}, #{I.end.y}"

  perform: (canvas) ->
    canvas.drawLine
      start: I.start
      end: I.end

window.Step = Step
