-- Ragebound's option pages; LibBound adds Extras and Skin, and builds the window.
local _, ns = ...
if ns.disabled then return end
local Bound = LibStub("LibBound-1.0")

local function BuffPage(UI)
	local p = UI.NewPage("Buffs", "A card when a buff is missing or running out. Click it to cast (out of combat).")
	local W = UI.CONTENT_W
	local third = math.floor(W / 3)
	for _, b in ipairs(ns.BUFFS) do
		p:Add(UI.Section(p, p.y - 2, b.label) + 2)
		UI.DBToggle(p, 0, p.y, third, b.key, "Show")
		UI.DBToggle(p, third, p.y, third, b.key .. "Sound", "Sound")
		UI.DBToggle(p, third * 2, p.y, third, b.key .. "Keep", "When missing", nil, function() ns.UpdateBuffTimers() end)
		p:Add(34)
		p:Add(select(2, UI.DBToggle(p, 0, p.y, W, b.key .. "Combat", "Only in combat",
			"You shout in the fight: out of combat the card stays quiet.", function() ns.UpdateBuffTimers() end)) + 6)
	end
	p:Add(UI.Note(p, p.y, "In combat the card is a reminder (it glows once you have the rage): cast from your bars."))
end

local function GearPage(UI)
	local p = UI.NewPage("Gear", "Durability of your equipped items, and a stone on your weapon.")
	local W = UI.CONTENT_W
	p:Add(UI.Section(p, p.y - 4, "Durability") + 2)
	p:Add(select(2, UI.DBToggle(p, 0, p.y, W, "durability", "Warn when an item's durability runs low", "Out of combat. A broken item (0%) is shown in red.")) + 6)
	p:Add(select(2, UI.Slider(p, p.y, "Warn at", "durabilityLow", 5, 75, 5, "%")) + 8)
	p:Add(UI.Section(p, p.y - 4, "Weapon stone") + 2)
	p:Add(select(2, UI.DBToggle(p, 0, p.y, W, "stone", "Show when your main hand has no stone", "A click uses the best sharpening stone (blades) or weighted stone (maces, staves) in your bags.")) + 8)
end

local function BandagePage(UI)
	local p = UI.NewPage("Bandages", "How many bandages you carry, once you know First Aid.")
	local W = UI.CONTENT_W
	p:Add(select(2, UI.DBToggle(p, 0, p.y, W, "bandages", "Warn when bandages run low", "Any bandage counts.")) + 6)
	p:Add(select(2, UI.Slider(p, p.y, "Warn below", "bandageLow", 1, 40, 1, " bandages")) + 8)
end

local function TravelPage(UI)
	local p = UI.NewPage("Travel", "Your Hearthstone beside the game menu (Escape).")
	p:Add(select(2, UI.DBToggle(p, 0, p.y, UI.CONTENT_W, "travel", "Show the travel panel when the game menu opens")) + 8)
end

ns.optionPages[#ns.optionPages + 1] = BuffPage
ns.optionPages[#ns.optionPages + 1] = GearPage
ns.optionPages[#ns.optionPages + 1] = BandagePage
-- the rage bar (LibBound): Marius' bar with the axe head
Bound.InstallPowerBar(ns, { power = 1, title = "Rage bar", noun = "rage" })
ns.optionPages[#ns.optionPages + 1] = TravelPage
Bound.InstallOptions(ns, { header = "Warrior helper", launcher = "Warrior helper: Battle Shout, gear, bandages." })
