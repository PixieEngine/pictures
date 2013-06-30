#= require ./datum

namespace "Models", (Models) ->
  Models.Data = (data) ->
    items = ko.observableArray()

    for key, value of data
      items.push Models.Datum(key, value)

    items: items
    addRow: ->
      @items.push Models.Datum("new_data", [])
