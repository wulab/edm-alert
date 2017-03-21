# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

sloganText = [
  'น้ำท่วม'
  'ฝนตก'
  'ME'
]

$(document).ready ->
  if $('.pages-index')[0]
    loopThroughTextList sloganText

loopThroughTextList = (textList) ->
  i = 0
  while i < textList.length
    do (i) ->
      setTimeout (->
        document.getElementById('random-slogan').innerHTML = textList[i]
        return
      ), 3000 * i
      return
    i++
