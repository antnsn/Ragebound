--@moods: rage blizzard flat
local T = dofile(wb.dir .. "/tests/_warrior.lua")
T.warrior({ 6673 })
wb.login({ saved = { RageboundDB = { skin = wb.mood } } })
wb.advance(7)
local want = ({ rage = "Rage", blizzard = "Blizzard", flat = "Flat" })[wb.mood]
wb.expect("active skin", wb.ns.UI.Active().name, want)
wb.check(wb.shown("RageboundBattleShoutFrame"), "a card builds in this skin")
wb.slash("/rage")
wb.check(wb.shown("RageboundOptions"), "the options build in this skin")
if wb.mood == "rage" then wb.expect("Rage is the default", wb.ns.defaults.skin, "rage") end
