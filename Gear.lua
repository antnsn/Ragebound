-- Durability card: an equipped item at or below the warning percentage, urgent once one is broken
-- (0%). The status names the worst item. Not clickable; quiet in combat.
local _, ns = ...
if ns.disabled then return end

-- the inventory slots that can lose durability, with their names
local SLOTS = {
	{ 1, "Head" }, { 3, "Shoulders" }, { 5, "Chest" }, { 6, "Waist" }, { 7, "Legs" }, { 8, "Feet" },
	{ 9, "Wrists" }, { 10, "Hands" }, { 15, "Back" }, { 16, "Main hand" }, { 17, "Off hand" }, { 18, "Ranged" },
}

-- the worst equipped item: slot name, percent left (0-100) and slot ID; nil without durability
function ns.WorstDurability()
	local name, pct, slot
	for _, s in ipairs(SLOTS) do
		local ok, cur, max = pcall(GetInventoryItemDurability, s[1])
		if ok and not ns.IsSecret(cur) and not ns.IsSecret(max) and cur and max and max > 0 then
			local p = cur / max * 100
			if not pct or p < pct then name, pct, slot = s[2], p, s[1] end
		end
	end
	return name, pct, slot
end

local M = {}
ns.modules[#ns.modules + 1] = M
local card

local function Status(name, pct)
	if pct <= 0 then return name .. " is broken" end
	return ("%s %d%%"):format(name, math.floor(pct + 0.5))
end

function M:Update()
	if not card then return end
	if ns.unlocked then
		card:SetIcon(136241); card:SetStatus("Legs 18%"); card:Show(); card:Glow(false)
		return
	end
	local name, pct, slot
	if ns.db.durability and not ns.InCombat() then name, pct, slot = ns.WorstDurability() end
	if name and pct <= ns.db.durabilityLow then
		local ok, tex = pcall(GetInventoryItemTexture, "player", slot)
		card:SetIcon((ok and not ns.IsSecret(tex) and tex) or 136241)
		card:SetStatus(Status(name, pct), pct <= 0)
		card:Show(); card:Glow(true)
	else
		card:Glow(false); card:Hide()
	end
end

function M:Init()
	card = ns.MakeCard("RageboundDurabilityFrame")
	card:SetIcon(136241) -- blacksmithing hammer
	card:SetTitle("Repair your gear")
	card:SetExplain(ns.Help.durability)
	ns.MakeMovable(card, "duPoint")
	ns.ApplyPoint(card, "duPoint")
	local f = CreateFrame("Frame")
	for _, e in ipairs({ "UPDATE_INVENTORY_DURABILITY", "PLAYER_EQUIPMENT_CHANGED", "PLAYER_REGEN_ENABLED",
		"PLAYER_REGEN_DISABLED", "PLAYER_ENTERING_WORLD" }) do f:RegisterEvent(e) end
	f:SetScript("OnEvent", function() M:Update() end)
	M:Update()
end
