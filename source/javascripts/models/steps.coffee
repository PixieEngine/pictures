namespace "Models", (Models) ->
  Models.Steps = (data) ->
    steps = ko.observableArray()
    active = ko.observable(0)

    steps: steps
    active: active

    add: (step) ->
      steps.push(step)
      active(steps().length - 1)

    pop: ->
      steps.pop()
      active(steps().length - 1)

    draw: (canvas, snaps=true) ->
      steps().forEach (step) ->
        step.perform(canvas, snaps)
