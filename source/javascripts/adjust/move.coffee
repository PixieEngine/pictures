namespace "Adjust", (Adjust) ->
  Adjust.Move = (I={}) ->
    I: I

    template: ->
      "description/move"

    move: (step, position) ->
      xDiff =  position.x - step.I.start.x()
      yDiff = position.y - step.I.start.y()

      # start by moving the start point
      step.I.start.x(position.x)
      step.I.start.y(position.y)



      # make sure to move the end the same amount
      step.I.end.x(step.I.end.x() + xDiff)
      step.I.end.y(step.I.end.y() + yDiff)

    perform: (canvas) ->
      ;
