namespace "Models", (Models) ->
  Models.Datum = (key, value) ->
    createObservableValue = (n) ->
      n: ko.observable n

    # Converts value to an array of observable values
    values = [].concat(value).map createObservableValue

    array = ko.observableArray values

    key: ko.observable key
    value: array
    type: 'number'
    addItem: ->
      @value.push createObservableValue(0)
