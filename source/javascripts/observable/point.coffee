namespace "Observable", (Observable) ->
  Observable.Point = (I={}) ->
    set: (attributes) ->
      for key, value of attributes
        @[key](value)

    x: ko.observable(I.x)
    y: ko.observable(I.y)
