namespace "Observable", (Observable) ->
  Observable.Point = (I={}) ->
    subscriptions = {}

    self =
      set: (attributes) ->
        for key, value of attributes
          @[key](value)

      value: ->
        Point(@x(), @y())

      bind: (property, observable) ->
        if previousSubscription = subscriptions[property]
          previousSubscription.dispose()

        subscriptions[property] = observable.subscribe (newValue) ->
          self[property](newValue)

        self[property](observable())

      x: ko.observable(I.x)
      y: ko.observable(I.y)

    return self
