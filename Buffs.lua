-- Self-buff card (LibBound buff timer): Battle Shout. It also buffs your party, but the card only
-- watches you. Click the card to cast (out of combat). Nothing shows while it isn't learned.
-- By default only in combat ("Only in combat"): there the card is a reminder, cast from your bars.
local _, ns = ...
if ns.disabled then return end
local D = ns.DATA

local function Name(list) local id = ns.BestRank(list) return id and ns.SpellName(id) end
local function BuffName(list, english) return ns.SpellName(list[1]) or english end
-- enough rage for it; rage it can't read counts as enough (the glow shows rather than hides)
local function HasRage(cost)
	local ok, p = pcall(UnitPower, "player", 1)
	if not ok or ns.IsSecret(p) or type(p) ~= "number" then return true end
	return p >= cost
end

local BUFFS = {
	{ key = "battleShout", frame = "RageboundBattleShoutFrame", label = "Battle Shout", icon = 132333,
		list = D.battleShout, duration = 120, cost = 10 },
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
		castIDs = b.list, duration = b.duration,
		ready = function() return not ns.InCombat() or HasRage(b.cost) end,
		goneText = function()
			if ns.InCombat() then return ("Missing: %d rage"):format(b.cost) end
			return ("Missing: click to cast (%d rage)"):format(b.cost)
		end,
	})
end
