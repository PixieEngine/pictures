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
          previousSubscription.invoke "dispose"

        # Bi-directional insanity
        to = observable.subscribe (newValue) ->
          self[property](newValue)

        myObservable = self[property]
        from = myObservable.subscribe (newValue) ->
          observable(newValue)

        subscriptions[property] = [to, from]

        # Update it in
        myObservable(observable())

      x: ko.observable(I.x)
      y: ko.observable(I.y)

    # TODO: Not sure if this is the best place for these
    self.x.subscribe ->
      refreshCanvas()
    self.y.subscribe ->
      refreshCanvas()

    return self
