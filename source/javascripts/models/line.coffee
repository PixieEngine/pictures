namespace "Models", (Models) ->
  Models.Line = (I={}) ->
    I: I

    template: ->
      "description/line"

    magnetPoints: ->
      [I.start.value(), I.end.value()]

    perform: (canvas) ->
      canvas.drawLine
        start: I.start.value()
        end: I.end.value()
        color: "black"
