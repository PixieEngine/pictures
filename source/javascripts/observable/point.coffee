namespace "Observable", (Observable) ->
  Observable.Point = (I={}) ->
    subscriptions = {}

    self =
      set: (attributes) ->
        for key, value of attributes
          @[key](value)

      value: ->
        Point(@x(), @y())

      # TODO: Instead of binding on `Point` maybe we should bind on `Step` instances
      bind: (property, source) ->
        observable = source.value()[0].n
        key = source.key

        self["#{property}Name"](key)

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

      xName: ko.observable()
      yName: ko.observable()

      # should we have a separate method
      # for the formatted versions of these?
      x: ko.observable(I.x.toFixed(1))
      y: ko.observable(I.y.toFixed(1))

    # TODO: Not sure if this is the best place for these
    self.x.subscribe ->
      refreshCanvas(false)
    self.y.subscribe ->
      refreshCanvas(false)

    return self
