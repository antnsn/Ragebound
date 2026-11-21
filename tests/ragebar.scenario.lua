--@moods: idle some full combat always off number vertical secret secretidle unlocked change flat blizzard flatvertical
-- the rage bar (LibBound): Marius' bar, filled to your rage, the number on it, a glowing line at
-- the fill's end and a glow round it at full; shown in combat or while you have rage
local T = dofile(wb.dir .. "/tests/_warrior.lua")
local m = wb.mood
T.warrior({ 6673 })
local p = wb.state.player
p.powerType, p.powerMax = 1, 100
p.power = ({ idle = 0, some = 40, full = 100, combat = 0, always = 0, off = 40, number = 40, vertical = 40,
	secret = 40, secretidle = 40, unlocked = 0, change = 0, flat = 100, blizzard = 40, flatvertical = 40 })[m]
if m == "secret" or m == "secretidle" then p.secretPower = true end
local db = {}
if m == "always" then db.powerAlways = true end
if m == "off" then db.powerBar = false end
if m == "number" then db.powerNumber = false end
if m == "vertical" or m == "flatvertical" then db.powerVertical = true end
if m == "flat" or m == "flatvertical" then db.skin = "flat" end
if m == "blizzard" then db.skin = "blizzard" end
wb.login({ saved = { RageboundDB = db } })
if m == "combat" or m == "secret" then wb.combat(true) end
local function Rage(n) p.power = n; wb.fire("UNIT_POWER_FREQUENT", "player", "RAGE") end
wb.advance(1)

local bar = wb.frame("RageboundPowerBar")
wb.check(bar ~= nil, "the bar exists")
local shown = wb.shown("RageboundPowerBar")
local sb = bar.status

if m == "idle" then
	wb.expect("no rage, out of combat: hidden", shown, false)
elseif m == "some" then
	wb.expect("shown with rage", shown, true)
	wb.expect("filled to the rage", sb:GetValue(), 40)
	wb.expect("out of 100", sb.__max, 100)
	wb.expect("the number on it", bar.text:GetText(), "40")
	wb.expect("the line at the fill's end", bar.spark:IsShown(), true)
	wb.expect("no full glow below 100", bar.full:IsShown(), false)
	wb.expect("horizontal by default", bar.vertical, false)
	wb.expect("the painted look in the Rage skin", bar.look, "painted")
	wb.check(bar:GetWidth() > bar:GetHeight(), "wider than tall")
elseif m == "full" then
	wb.expect("full: the glow", bar.full:IsShown(), true)
	wb.expect("full: no line (the fill reaches the end)", bar.spark:IsShown(), false)
elseif m == "combat" then
	wb.expect("in combat, even with no rage: shown", shown, true)
	wb.expect("empty: no line", bar.spark:IsShown(), false)
elseif m == "always" then
	wb.expect("shown always when picked", shown, true)
elseif m == "off" then
	wb.expect("hidden when the bar is off", shown, false)
elseif m == "number" then
	wb.expect("the number can be turned off", bar.text:IsShown(), false)
elseif m == "vertical" then
	wb.expect("vertical when picked", bar.vertical, true)
	wb.check(bar:GetHeight() > bar:GetWidth(), "taller than wide")
	wb.ns.db.powerVertical = false
	wb.ns.Refresh()
	wb.expect("switches back without a reload", bar.vertical, false)
	wb.check(bar:GetWidth() > bar:GetHeight(), "wider than tall again")
elseif m == "secret" then
	-- rage the addon can't read: the game still fills the bar and writes the number
	wb.expect("in combat: shown", shown, true)
	wb.expect("the bar gets the value as it is", sb:GetValue(), wb.SECRET)
	wb.expect("and the number too", bar.text:GetText(), wb.SECRET)
	wb.expect("no full glow (it can't tell)", bar.full:IsShown(), false)
	wb.expect("and no error", #wb.takeErrors(), 0)
elseif m == "secretidle" then
	wb.expect("out of combat, unreadable: hidden", shown, false)
elseif m == "unlocked" then
	wb.ns.ToggleMove()
	wb.expect("shown while unlocked, to place it", wb.shown("RageboundPowerBar"), true)
	local moved = false
	for _, mv in ipairs(wb.ns.movers) do if mv.frame == bar then moved = mv.key == "pbPoint" end end
	wb.check(moved, "it can be moved (saved as pbPoint)")
	wb.ns.ToggleMove()
	wb.expect("hidden again once locked", wb.shown("RageboundPowerBar"), false)
elseif m == "flat" or m == "blizzard" then
	-- the Blizzard and Flat skins: a plain bar instead of the painted one
	wb.expect("the plain look (" .. m .. ")", bar.look, m)
	wb.expect("shown, filled", sb:GetValue(), m == "flat" and 100 or 40)
	wb.check(bar:GetWidth() > bar:GetHeight(), "wider than tall")
	if m == "flat" then wb.expect("full: its edge lights up", bar.full:IsShown(), true) end
elseif m == "flatvertical" then
	wb.expect("plain and vertical", bar.look == "flat" and bar.vertical, true)
	wb.check(bar:GetHeight() > bar:GetWidth(), "taller than wide")
elseif m == "change" then
	Rage(25)
	wb.expect("rage comes in: shown", wb.shown("RageboundPowerBar"), true)
	wb.expect("filled to it", sb:GetValue(), 25)
	Rage(100)
	wb.expect("full glow", bar.full:IsShown(), true)
	Rage(0)
	wb.expect("spent, out of combat: hidden", wb.shown("RageboundPowerBar"), false)
end

for _, bad in ipairs({ "AnimGroup:SetLoopType", "Anim:SetScale" }) do
	wb.check(not wb.gaps[bad], "no " .. bad .. " (not in the game)")
end
