namespace "Models", (Models) ->
  hotkeys =
    draw:
      line: "x"
      path: "a"
      rectangle: "r"
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

  Models.Hotkeys = (data) ->
    groups = ko.observableArray()

    for group, keys of hotkeys
      group = []

      for action, key of keys
        group.push
          name: action
          value: key

      groups.push group

    activeKey: ko.observable('x')
    groups: groups
