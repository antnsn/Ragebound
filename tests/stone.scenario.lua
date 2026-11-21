--@moods: default sword mace staff best toolow nostone enchanted fishing noweapon combat
local T = dofile(wb.dir .. "/tests/_warrior.lua")
local m = wb.mood
T.warrior({ 6673 })
local b = wb.state.bags
b[2862] = 3; b[3239] = 2 -- rough stones of both kinds
if m == "best" or m == "toolow" then b[2863] = 1; b[7964] = 4 end -- coarse and solid sharpening stones too
if m == "nostone" then b[2862] = 0 end
if m == "mace" then T.weapon(1001, 4)
elseif m == "staff" then T.weapon(1002, 10)
elseif m == "fishing" then T.weapon(1003, 20)
elseif m ~= "noweapon" then T.weapon(1000, 7) end -- a sword
local db = { stone = m ~= "default" }
wb.login({ saved = { RageboundDB = db } })
if m == "enchanted" then wb.setWeaponEnchant(1800, 1) end
if m == "toolow" then
	-- the solid stone needs a higher level than yours: the coarse one is used instead
	local info = wb.G.C_Item.GetItemInfo
	wb.G.C_Item.GetItemInfo = function(id)
		local name = info(id) or ("Item" .. id)
		return name, nil, 1, 1, id == 7964 and 99 or 1
	end
	wb.fire("BAG_UPDATE_DELAYED")
end
wb.advance(3)
local card = wb.frame("RageboundStoneFrame")
local shown = wb.shown("RageboundStoneFrame")
local status = card.statusText:GetText() or ""
if m == "default" then
	wb.expect("off by default", wb.ns.db.stone, false)
	wb.expect("no card while off", shown, false)
elseif m == "enchanted" or m == "fishing" or m == "noweapon" then
	wb.expect("no stone card (" .. m .. ")", shown, false)
elseif m == "nostone" then
	wb.expect("card when no stone is on", shown, true)
	wb.expect("says none is in the bags", status, "No sharpening stone in your bags")
	wb.check(not T.macroFor("/use"), "and takes no click")
else
	wb.expect("card when the weapon has no stone", shown, true)
	local id = ({ sword = 2862, mace = 3239, staff = 3239, best = 7964, toolow = 2863, combat = 2862 })[m]
	wb.check(T.macroFor(("/use item:%d\n/use 16"):format(id)), "a click uses stone " .. id .. " on the main hand")
	wb.check(status:find("click for", 1, true), "the status says what a click uses")
end
if m == "combat" then
	wb.combat(true)
	wb.advance(1)
	wb.expect("quiet in combat", wb.shown("RageboundStoneFrame"), false)
	wb.combat(false)
	wb.advance(1)
	wb.expect("back after", wb.shown("RageboundStoneFrame"), true)
	wb.check(T.macroFor("/use item:2862"), "clickable again after combat")
	wb.setWeaponEnchant(1800, 1)
	wb.advance(2)
	wb.expect("gone once the stone is on", wb.shown("RageboundStoneFrame"), false)
end
