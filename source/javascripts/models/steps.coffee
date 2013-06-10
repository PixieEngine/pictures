namespace "Models", (Models) ->
  Models.Steps = (data) ->
    steps = ko.observableArray()
    active = ko.observable()

    steps: steps
    active: active

    push: (step) ->
      steps.push(step)
      active(step)

    pop: ->
      steps.pop()
      active(steps[steps.length - 1])

    draw: (canvas, snaps=true) ->
      steps().forEach (step) ->
        snaps = step is active()
        step.perform(canvas, snaps)
