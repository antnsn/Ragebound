-- Ragebound's look, "Rage": dark iron panels with a blood-red edge, smoke and embers drifting
-- over them, rivets in the corners, a slow ember-red rim while a card needs you.
-- LibBound derives the Blizzard and Flat skins from it.
-- Textures: tools/make_media.py.
local _, ns = ...
if ns.disabled then return end
local Bound = LibStub("LibBound-1.0")
local F = Bound.FONTS

local rage = {
	name = "Rage",
	font = { ui = F.friz, title = F.friz, narrow = F.arialn, card = F.morpheus },
	color = {
		bg = { 0, 0, 0, 0 },
		side = { 0.05, 0.03, 0.03, 0.40 },
		header = { 0.05, 0.03, 0.03, 0.35 },
		border = { 0.70, 0.24, 0.18, 0.9 },
		hover = { 0.26, 0.10, 0.08, 1 },
		selected = { 0.22, 0.09, 0.07, 1 },
		text = { 0.98, 0.93, 0.88 },
		dim = { 0.74, 0.66, 0.62 },
		accent = { 1.00, 0.52, 0.28 },
		track = { 0.16, 0.08, 0.07, 1 },
		button = { 0.09, 0.06, 0.05, 1 },
		navGlow = { 0.95, 0.40, 0.22, 0.60 },
		row = { 0.13, 0.08, 0.07, 0.8 },
		rowWarn = { 0.40, 0.30, 0.05, 0.5 },
		rowBad = { 0.45, 0.08, 0.10, 0.55 },
		highlight = { 1, 0.80, 0.70, 0.08 },
		cell = { 0.12, 0.08, 0.07, 0.85 },
		cdText = { 1, 0.92, 0.86 },
		glow = { 1, 0.48, 0.24 },
		gridLine = { 1, 0.80, 0.70, 0.08 },
		gridCentre = { 0.95, 0.40, 0.22, 0.45 },
	},
	box = {
		backdrop = {
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true, tileSize = 16, edgeSize = 14,
			insets = { left = 3, right = 3, top = 3, bottom = 3 },
		},
		bg = { 0.08, 0.06, 0.06 },
		border = { 0.78, 0.30, 0.22, 1 },
	},
	dialog = {
		backdrop = {
			bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
			edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
			tile = true, tileSize = 32, edgeSize = 32,
			insets = { left = 11, right = 11, top = 12, bottom = 11 },
		},
		outset = 10,
		border = { 0.82, 0.36, 0.26, 1 },
		under = { 0.05, 0.03, 0.03, 1 },
		plate = false,
	},
	tex = Bound.STOCK_TEX,
	card = {
		panel = { 0.10, 0.08, 0.08, 0.94 },
		gilt = { 0.72, 0.22, 0.16, 1 },
		giltFaint = { 0.42, 0.30, 0.26, 0.9 },
		light = { 1, 0.86, 0.76, 0.06 },
		rays = { 1, 0.56, 0.30 },
		raysFaded = { 0.62, 0.52, 0.48 },
		title = { 1, 0.88, 0.80 },
		status = { 0.92, 0.84, 0.78 },
		urgent = { 1, 0.42, 0.30 },
		glowEdge = { 1, 0.50, 0.28, 1 },
		iconEdge = { 0.56, 0.48, 0.44, 0.9 },
		frost = "Smoke", frostTint = { 1, 0.50, 0.30, 0.14 },
		crest = "Crest", crestTint = { 1, 0.62, 0.50, 0.15 },
		studs = "Rivet",
		rim = "Rim", breathe = true, breatheTime = 2.8,
		burst = false, shards = false, ring = false, round = false,
	},
	widgets = "blizzard",
}

Bound.InstallSkin(ns, {
	skins = { rage = rage },
	order = { "rage", "blizzard", "flat" },
	default = "rage",
	about = { rage = "Dark iron with a blood-red edge, smoke, embers and rivets." },
})
Bound.InstallBuffTimers(ns)
Bound.InstallMinimap(ns)
