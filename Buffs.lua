-- Self-buff card (LibBound buff timer): Battle Shout. It also buffs your party, but the card only
-- watches you. Click the card to cast (out of combat). Nothing shows while it isn't learned.
local _, ns = ...
if ns.disabled then return end
local D = ns.DATA

local function Name(list) local id = ns.BestRank(list) return id and ns.SpellName(id) end
local function BuffName(list, english) return ns.SpellName(list[1]) or english end

local BUFFS = {
	{ key = "battleShout", frame = "RageboundBattleShoutFrame", label = "Battle Shout", icon = 132333,
		list = D.battleShout },
}
ns.BUFFS = BUFFS

for _, b in ipairs(BUFFS) do
	ns.MakeBuffTimer({
		key = b.key, point = b.key .. "Point", frameName = b.frame,
		label = b.label, icon = b.icon,
		names = function() return { BuffName(b.list, b.label) } end,
		active = function() return ns.BestRank(b.list) ~= nil end,
		cast = function() return Name(b.list) end,
		explain = ns.Help[b.key],
		goneText = "Missing: click to cast (10 rage)",
	})
end
