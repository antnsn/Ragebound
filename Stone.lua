-- Weapon stone card (off by default): your main hand has no temporary enchant. A click uses the
-- best stone you carry on it: a sharpening stone for blades, a weighted stone for maces and staves.
-- Without a fitting stone in your bags the card says so and takes no click. Quiet in combat.
local _, ns = ...
if ns.disabled then return end
local D = ns.DATA

-- weapon subclasses (item class 2): which stone fits
local SHARP = { [0] = true, [1] = true, [6] = true, [7] = true, [8] = true, [13] = true, [15] = true } -- axes, polearms, swords, fist weapons, daggers
local BLUNT = { [4] = true, [5] = true, [10] = true } -- maces, staves

local function Count(id)
	local ok, n = pcall(C_Item.GetItemCount, id)
	return (ok and not ns.IsSecret(n) and n) or 0
end

-- "sharpening", "weighted", or nil when the main hand takes no stone (empty, fishing pole, ...)
function ns.StoneKind()
	local ok, id = pcall(GetInventoryItemID, "player", 16)
	if not ok or ns.IsSecret(id) or not id then return nil end
	local ok2, _, _, _, _, _, classID, subclassID = pcall(C_Item.GetItemInfoInstant, id)
	if not ok2 or ns.IsSecret(classID) or ns.IsSecret(subclassID) or classID ~= 2 then return nil end
	if SHARP[subclassID] then return "sharpening" end
	if BLUNT[subclassID] then return "weighted" end
	return nil
end

-- false when the stone needs a higher level than yours (unknown counts as usable)
local function Usable(id)
	local ok, name, _, _, _, minLevel = pcall(C_Item.GetItemInfo, id)
	if not ok or not name or ns.IsSecret(minLevel) or type(minLevel) ~= "number" then return true end
	local ok2, level = pcall(UnitLevel, "player")
	if not ok2 or ns.IsSecret(level) or type(level) ~= "number" then return true end
	return minLevel <= level
end

-- the best stone of that kind in your bags that you can use: item ID and name, or nil
function ns.BestStone(kind)
	local list = D[kind]
	if not list then return nil end
	for i = #list, 1, -1 do
		local id = list[i]
		if Count(id) > 0 and Usable(id) then
			local ok, n = pcall(C_Item.GetItemNameByID, id)
			return id, (ok and not ns.IsSecret(n) and n) or D.stoneNames[id]
		end
	end
end

-- true when the main hand has a temporary enchant; nil when it can't be read
local function Enchanted()
	local ok, has = pcall(GetWeaponEnchantInfo)
	if not ok or ns.IsSecret(has) then return nil end
	return has and true or false
end

local M = {}
ns.modules[#ns.modules + 1] = M
local card, overlay

function M:Update()
	if not card then return end
	if ns.unlocked then
		card:SetStatus("Missing: click to use"); card:Show(); card:Glow(false)
		if not InCombatLockdown() then overlay:Sync(nil) end
		return
	end
	local kind = ns.db.stone and not ns.InCombat() and ns.StoneKind()
	local show, use, macro = false, nil, nil
	if kind and Enchanted() == false then
		show = true
		local id, name = ns.BestStone(kind)
		if id then
			use = name
			macro = ("/use item:%d\n/use 16"):format(id)
			card:SetStatus("Missing: click for " .. name, true)
		else
			card:SetStatus(kind == "sharpening" and "No sharpening stone in your bags" or "No weighted stone in your bags")
		end
	end
	if show then
		card:Show(); card:Glow(use ~= nil)
	else
		card:Glow(false); card:Hide()
	end
	if not InCombatLockdown() then overlay:Sync(use, "player", ns.Help.stone, macro) end
end

function M:Init()
	card = ns.MakeCard("RageboundStoneFrame")
	local ok, tex = pcall(C_Item.GetItemIconByID, D.sharpening[1])
	card:SetIcon((ok and not ns.IsSecret(tex) and tex) or 135248)
	card:SetTitle("Weapon stone")
	card:SetExplain(ns.Help.stone)
	ns.MakeMovable(card, "stPoint")
	ns.ApplyPoint(card, "stPoint")
	overlay = ns.CastOverlay(card)
	local f = CreateFrame("Frame")
	for _, e in ipairs({ "PLAYER_REGEN_ENABLED", "PLAYER_REGEN_DISABLED", "PLAYER_ENTERING_WORLD",
		"PLAYER_EQUIPMENT_CHANGED", "BAG_UPDATE_DELAYED" }) do f:RegisterEvent(e) end
	f:RegisterUnitEvent("UNIT_INVENTORY_CHANGED", "player")
	f:SetScript("OnEvent", function() M:Update() end)
	C_Timer.NewTicker(1, function() M:Update() end) -- the enchant wears off without an event
	M:Update()
end
