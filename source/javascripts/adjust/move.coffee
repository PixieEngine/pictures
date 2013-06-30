namespace "Adjust", (Adjust) ->
  Adjust.Move = (I={}) ->
    I: I

    template: ->
      "description/move"

    move: (step, position) ->
      step.moveTo(position)

    perform: (canvas) ->
      ;
