-- Bandage card: fewer bandages in your bags than the warning count, once you know First Aid.
-- Any Classic bandage counts. Not clickable; quiet in combat.
local _, ns = ...
if ns.disabled then return end
local D = ns.DATA

local function Count(id)
	local ok, n = pcall(C_Item.GetItemCount, id)
	return (ok and not ns.IsSecret(n) and n) or 0
end

-- how many bandages you carry, or nil before you know First Aid
function ns.BandageCount()
	if not ns.BestRank(D.firstAid) then return nil end
	local n = 0
	for _, id in ipairs(D.bandages) do n = n + Count(id) end
	return n
end

local M = {}
ns.modules[#ns.modules + 1] = M
local card

function M:Update()
	if not card then return end
	if ns.unlocked then card:SetStatus("Bandages: 3"); card:Show(); card:Glow(false) return end
	local n = ns.db.bandages and not ns.InCombat() and ns.BandageCount()
	if n and n < ns.db.bandageLow then
		card:SetStatus("Bandages: " .. n, n == 0)
		card:Show(); card:Glow(true)
	else
		card:Glow(false); card:Hide()
	end
end

function M:Init()
	card = ns.MakeCard("RageboundBandagesFrame")
	local ok, tex = pcall(C_Item.GetItemIconByID, D.bandages[1])
	card:SetIcon((ok and not ns.IsSecret(tex) and tex) or 133688)
	card:SetTitle("Bandages running low")
	card:SetExplain(ns.Help.bandages)
	ns.MakeMovable(card, "bdPoint")
	ns.ApplyPoint(card, "bdPoint")
	local f = CreateFrame("Frame")
	for _, e in ipairs({ "BAG_UPDATE_DELAYED", "SPELLS_CHANGED", "PLAYER_REGEN_ENABLED", "PLAYER_REGEN_DISABLED",
		"PLAYER_ENTERING_WORLD" }) do f:RegisterEvent(e) end
	f:SetScript("OnEvent", function() M:Update() end)
	M:Update()
end
