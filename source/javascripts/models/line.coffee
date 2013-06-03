namespace "Models", (Models) ->
  Models.Line = (I={}) ->
    I: I

    template: ->
      "description/line"

    perform: (canvas) ->
      canvas.drawLine
        start: I.start.value()
        end: I.end.value()
        color: "black"
