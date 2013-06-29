namespace "Observable", (Observable) ->
  Observable.Point = (I={}) ->
    subscriptions = {}
    sources = {}

    self =
      set: (attributes) ->
        for key, value of attributes
          @[key](value)

      value: (n=0) ->
        if x = sources["x"]
          x = x.value().wrap(n).n()
        if y = sources["y"]
          y = y.value().wrap(n).n()

        Point(x ? @x(), y ? @y())

      # TODO: Instead of binding on `Point` maybe we should bind on `Step` instances
      bind: (property, source) ->
        observable = source.value()[0].n
        key = source.key

        sources[key] = source

        self["#{property}Name"](key)

        # TODO Need to observe all source values for live-updating iterations

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
      x: ko.observable(parseFloat(I.x.toFixed(1)))
      y: ko.observable(parseFloat(I.y.toFixed(1)))

    # TODO: Not sure if this is the best place for these
    self.x.subscribe ->
      refreshCanvas(false)
    self.y.subscribe ->
      refreshCanvas(false)

    return self
