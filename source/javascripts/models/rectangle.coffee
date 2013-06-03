namespace "Models", (Models) ->
  Models.Rectangle = (I={}) ->
    I: I

    template: ->
      "description/rectangle"

    perform: (canvas) ->
      canvas.drawRect
        x: I.start.x()
        y: I.start.y()
        width: I.end.x() - I.start.x()
        height: I.end.y() - I.start.y()
        color: "black"
