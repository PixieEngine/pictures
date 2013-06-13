namespace "Models", (Models) ->
  Models.Menu = ->
    step = ko.observable()
    visible = ko.observable(false)

    visible: visible

    color: ->
      "#{step()?.color() || '#000'}"

    strokeWidth: ->
      "#{step()?.strokeWidth() || '1px'}"

    x: ->
      "#{step()?.I?.start?.x() || 0}px"

    y: ->
      "#{step()?.I?.start?.y() || 0}px"

    measurements: ->
      step()?.measurements() || []

    step: step

    show: (s) ->
      visible(true)
      step(s)
