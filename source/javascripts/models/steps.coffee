namespace "Models", (Models) ->
  Models.Steps = (data) ->
    steps = ko.observableArray()
    active = ko.observable()
    iterated = ko.observable(true)

    steps: steps
    active: active
    iterated: iterated

    at: (position) ->
      steps().map (step) ->
        step if step.overlaps(position)

    push: (step) ->
      steps.push(step)
      active(step)

    pop: ->
      steps.pop()
      active(steps[steps.length - 1])

    draw: (canvas) ->
      if iterated()
        steps().forEach (step) ->
          snaps = step is active()

          # TODO Real count for iterations
          iterations = 5

          iterations.times (n) ->
            step.perform canvas,
              snaps: snaps
              n: n
      else
        steps().forEach (step) ->
          snaps = step is active()
          step.perform canvas,
            snaps: snaps
