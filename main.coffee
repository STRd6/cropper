do ->
  styleNode = document.createElement("style")
  styleNode.innerHTML = require "./style"
  document.head.appendChild(styleNode)

document.body.appendChild require("./template")({})
img = document.querySelector('img')
crop = document.querySelector('crop')

Drop = require "./lib/drop"

Drop document, (e) ->
  file = e.dataTransfer.files[0]

  console.log file
  if file
    img.src = URL.createObjectURL(file)
