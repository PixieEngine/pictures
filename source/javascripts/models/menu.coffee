namespace "Models", (Models) ->
  Models.Menu = ->
    step = ko.observable()
    visible = ko.observable(false)

    visible: visible

    color: ->
      step()?.color

    strokeColor: ->
      step()?.strokeColor

    strokeWidth: ->
      step()?.strokeWidth

    type: ->
      step()?.type

    x: ->
      # hardcoded 100 since menu width is 200
      "#{step()?.center().x - 100 || 0}px"

    y: ->
      "#{step()?.center().y || 0}px"

    measurements: ->
      step()?.measurements() || []

    step: step

    hide: ->
      visible(false)

    show: (s) ->
      visible(true)
      step(s)
