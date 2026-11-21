--@moods: nofirstaid few none enough mixed rank off combat
local T = dofile(wb.dir .. "/tests/_warrior.lua")
local m = wb.mood
local known = ({ nofirstaid = { 6673 }, rank = { 6673, 7924 } })[m] or { 6673, 3273 }
T.warrior(known)
local b = wb.state.bags
if m == "nofirstaid" or m == "few" or m == "off" or m == "combat" or m == "rank" then b[1251] = 2 end
if m == "enough" then b[1251] = 5 end -- the default warns below 5
if m == "mixed" then b[1251] = 1; b[3530] = 1; b[14530] = 1 end
local db = {}
if m == "off" then db.bandages = false end
wb.login({ saved = { RageboundDB = db } })
wb.advance(3)
local card = wb.frame("RageboundBandagesFrame")
local shown = wb.shown("RageboundBandagesFrame")
if m == "nofirstaid" or m == "enough" or m == "off" then
	wb.expect("no bandage card (" .. m .. ")", shown, false)
else
	wb.expect("bandage card", shown, true)
	local want = ({ few = "Bandages: 2", none = "Bandages: 0", mixed = "Bandages: 3", rank = "Bandages: 2",
		combat = "Bandages: 2" })[m]
	wb.expect("counts every bandage", card.statusText:GetText(), want)
end
if m == "combat" then
	wb.combat(true)
	wb.advance(1)
	wb.expect("quiet in combat", wb.shown("RageboundBandagesFrame"), false)
end
