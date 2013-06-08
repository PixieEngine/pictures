#= require jquery.hotkeys
#= require_tree ./models

hotkeys =
  draw:
    line: "x"
    path: "a"
    rect: "r"
    circle: "c"
    text: "t"
    magnet: "u"
    picture: "p"
  adjust:
    move: "v"
    scale: "s"
    rotate: "e"
    duplicate: "d"
  flow:
    loop: "l"
    if: "i"
  modifiers:
    guide: "g"
    clip: "k"


$("#hotkeys").append JST["templates/hotkeys"](data: hotkeys)

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

[
  ["v", "Move"]
  ["s", "Scale"]
  ["e", "Rotate"]
  ["d", "Duplicate"]
].each ([key, tool]) ->
  $(document).on "keydown", null, key, ->
    window.activeTool = Adjust[tool]
