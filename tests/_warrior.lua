-- shared setup: a warrior with the given spells known (loaded with dofile)
local M = {}
local NAMES = {
	[6673] = "Battle Shout", [5242] = "Battle Shout", [6192] = "Battle Shout", [11549] = "Battle Shout",
	[11550] = "Battle Shout", [11551] = "Battle Shout", [25289] = "Battle Shout",
	[3273] = "First Aid", [3274] = "First Aid", [7924] = "First Aid", [10846] = "First Aid",
	[429959] = "Well-Rested",
}
function M.warrior(known)
	local s = wb.state
	s.player.classFile, s.player.class, s.player.classId = "WARRIOR", "Warrior", 1
	for id, n in pairs(NAMES) do s.spells[id] = n; s.known[id] = false end
	for _, id in ipairs(known or {}) do s.known[id] = nil end
	s.known[429959] = nil
end
-- durability per inventory slot ({ [slot] = { cur, max } }); the stub has no GetInventoryItemDurability,
-- so this runs after wb.login (wb.G exists then) and fires the game's event for it
function M.durability(t)
	wb.G.GetInventoryItemDurability = function(slot)
		local d = t[slot]
		if d then return d[1], d[2] end
		return nil
	end
	wb.fire("UPDATE_INVENTORY_DURABILITY")
end
-- a weapon in the main hand: item class 2 with the given subclass (7 sword, 4 mace, 10 staff, 20 fishing pole)
function M.weapon(id, subclass)
	wb.state.items[id] = { name = "Weapon" .. id, type = "Weapon", classID = 2, subclassID = subclass }
	wb.state.slots[16] = id
end
function M.macroFor(text)
	for _, f in ipairs(wb.frames()) do
		local m = f:GetAttribute("macrotext")
		if m and f.__shown and m:find(text, 1, true) then return f end
	end
end
return M
