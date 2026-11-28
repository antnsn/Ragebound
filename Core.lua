-- Ragebound: the Warrior addon of the Bound family, built on LibBound-1.0 (the shared core).
-- This file sets the addon up; every other file returns at once on a non-warrior (ns.disabled).
-- Warriors have no travel spells: LibBound adds the travel panel with only the Hearthstone.
local addonName, ns = ...
local Bound = LibStub("LibBound-1.0")

-- Spells and items, lowest rank (or quality) first. Classic IDs; Forever follows Classic content.
-- Checked in game before each release.
ns.DATA = {
	battleShout = { 6673, 5242, 6192, 11549, 11550, 11551, 25289 },
	-- First Aid: Apprentice, Journeyman, Expert, Artisan (any one counts as knowing it)
	firstAid = { 3273, 3274, 7924, 10846 },
	-- Linen, Heavy Linen, Wool, Heavy Wool, Silk, Heavy Silk, Mageweave, Heavy Mageweave,
	-- Runecloth, Heavy Runecloth
	bandages = { 1251, 2581, 3530, 3531, 6450, 6451, 8544, 8545, 14529, 14530 },
}

local function Timer(key, x, y, keep)
	return key, true, key .. "Minutes", 2, key .. "Sound", false, key .. "Icon", true, key .. "Keep", keep,
		key .. "Point", { "CENTER", "UIParent", "CENTER", x, y }
end
local defaults = {
	skin = "rage",
	durability = true, durabilityLow = 25,
	duPoint = { "CENTER", "UIParent", "CENTER", 250, 200 },
	bandages = true, bandageLow = 5,
	bdPoint = { "CENTER", "UIParent", "CENTER", 250, 80 },
	wrPoint = { "CENTER", "UIParent", "CENTER", 0, 320 },
	wfPoint = { "CENTER", "UIParent", "CENTER", 0, 260 },
}
-- one block of settings per buff card: <key>, <key>Minutes, Sound, Icon, Keep and its place
for _, t in ipairs({ { "battleShout", -250, 200, true } }) do
	local kv = { Timer(t[1], t[2], t[3], t[4]) }
	for i = 1, #kv, 2 do defaults[kv[i]] = kv[i + 1] end
end
-- Battle Shout lasts 2 minutes: warn with 30 seconds left, not at the start. It is shouted in
-- the fight (rage), so by default the card only shows in combat
defaults.battleShoutMinutes = 0.5
defaults.battleShoutCombat = true

ns.disabled = Bound:NewAddon(addonName, ns, {
	class = "WARRIOR",
	title = "Ragebound",
	prefix = "e0503a",
	db = "RageboundDB",
	slash = { "/rage", "/ragebound" },
	media = "Interface\\AddOns\\Ragebound\\Media\\",
	defaults = defaults,
})
