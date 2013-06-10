namespace "Models", (Models) ->
  Models.Datum = (key, value) ->
    # Converts value to an array of observable values
    values = [].concat(value).map (n) ->
      n: ko.observable n

    array = ko.observableArray values

    key: key
    value: array
