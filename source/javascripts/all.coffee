#= require hamlcoffee
#= require jquery
#= require "knockout-2.2.1.js"
#= require bootstrap

#= require_tree .

$("#hotkeys").append JST["templates/hotkeys"]()
