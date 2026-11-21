--@moods: fine low worst broken threshold off combat nogear
local T = dofile(wb.dir .. "/tests/_warrior.lua")
local m = wb.mood
T.warrior({ 6673 })
local dur = ({
	fine = { [1] = { 80, 100 }, [16] = { 60, 100 } },
	low = { [1] = { 80, 100 }, [7] = { 20, 100 } },
	worst = { [5] = { 20, 100 }, [16] = { 10, 100 }, [8] = { 24, 100 } },
	broken = { [5] = { 20, 100 }, [10] = { 0, 40 } },
	threshold = { [7] = { 40, 100 } },
	off = { [7] = { 10, 100 } },
	combat = { [7] = { 10, 100 } },
	nogear = {},
})[m]
local db = {}
if m == "threshold" then db.durabilityLow = 50 end
if m == "off" then db.durability = false end
wb.login({ saved = { RageboundDB = db } })
T.durability(dur)
wb.advance(2)
local card = wb.frame("RageboundDurabilityFrame")
local shown = wb.shown("RageboundDurabilityFrame")
if m == "fine" or m == "off" or m == "nogear" then
	wb.expect("no durability card (" .. m .. ")", shown, false)
else
	wb.expect("durability card", shown, true)
	local want = ({ low = "Legs 20%", worst = "Main hand 10%", broken = "Hands is broken", threshold = "Legs 40%",
		combat = "Legs 10%" })[m]
	wb.expect("names the worst item", card.statusText:GetText(), want)
end
if m == "broken" then
	local r, g, b = card.statusText:GetTextColor()
	local u = wb.ns.UI.Active().card.urgent
	wb.check(math.abs(r - u[1]) < 0.01 and math.abs(g - u[2]) < 0.01 and math.abs(b - u[3]) < 0.01,
		"a broken item is urgent (red)")
end
if m == "low" then
	local r, g, b = card.statusText:GetTextColor()
	local st = wb.ns.UI.Active().card.status
	wb.check(math.abs(r - st[1]) < 0.01 and math.abs(g - st[2]) < 0.01 and math.abs(b - st[3]) < 0.01,
		"low but not broken: the normal color")
end
if m == "combat" then
	wb.combat(true)
	wb.advance(1)
	wb.expect("quiet in combat", wb.shown("RageboundDurabilityFrame"), false)
	wb.combat(false)
	wb.advance(1)
	wb.expect("back after the fight", wb.shown("RageboundDurabilityFrame"), true)
end
