#= require jquery.hotkeys
#= require_tree ./models

# TODO Hotkeys view class
hotkeys = Models.Hotkeys()
hotkeysElement = $(JST["templates/hotkeys"]())
$("#hotkeys").append hotkeysElement
ko.applyBindings hotkeys, hotkeysElement.get(0)

window.activeTool = Models.Line

# TODO expose active tool through a tool palette model rather than a global
# TODO Share hotkey binding and hotkey text display data
# TODO Bind to only one key handling event and delegate
[
  ["r", "Rectangle"]
  ["x", "Line"]
  ["c", "Circle"]
].each ([key, tool]) ->
  $(document).on "keydown", null, key, ->
    window.activeTool = Models[tool]

    hotkeys.activeKey(key)

[
  ["v", "Move"]
  ["s", "Scale"]
  ["e", "Rotate"]
  ["d", "Duplicate"]
].each ([key, tool]) ->
  $(document).on "keydown", null, key, ->
    window.activeTool = Adjust[tool]
