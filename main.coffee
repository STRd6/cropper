do ->
  styleNode = document.createElement("style")
  styleNode.innerHTML = require "./style"
  document.head.appendChild(styleNode)

document.body.appendChild require("./template")({})
img = document.querySelector('img')
crop = document.querySelector('canvas')

Drop = require "./lib/drop"

Drop document, (e) ->
  file = e.dataTransfer.files[0]

  if file
    handleFile(file)

document.addEventListener "paste", (event) ->
  Array::some.call event.clipboardData.items, (item) ->
    if item.type.match /^image\//
      file = item.getAsFile()
      handleFile(file)

      return true
    else
      return false

handleFile = (file) ->
  new Promise (resolve, reject) ->
    img.onload = ->
      resolve img
    img.onerror = reject
    img.src = URL.createObjectURL(file)
  .then (img) ->
    ctx = crop.getContext('2d')
    ctx.fillStyle = "white"
    ctx.fillRect(0, 0, crop.width, crop.height)
    ctx.drawImage(img, 
      0, 0, img.width, img.height, 
      0, 0, img.width, img.height
    )
