Nf.console = Geyser.MiniConsole:new({
  name = "NfConsole",
  x = "50%",
  y = "0%",
  width = "100%",
  height = "50%",
})

setMiniConsoleFontSize("NfConsole", 14)
setWindowWrap("NfConsole", 160)
-- start it hidden, show it if we need it
Nf.console:hide()
