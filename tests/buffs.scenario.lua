--@moods: fresh missing buffed rank off expiring
local T = dofile(wb.dir .. "/tests/_warrior.lua")
local m = wb.mood
local known = ({ fresh = {}, missing = { 6673 }, buffed = { 6673 }, rank = { 6673, 5242, 6192 },
	off = { 6673 }, expiring = { 6673 } })[m]
T.warrior(known)
local s = wb.state
-- a different name for rank 3 shows which rank a click casts (the game's /cast by name does the same)
if m == "rank" then s.spells[6192] = "Battle Shout (Rank 3)" end
if m == "buffed" then s.auras.player = { wb.aura("Battle Shout", 6673, 120) } end
if m == "expiring" then s.auras.player = { wb.aura("Battle Shout", 6673, 20) } end
local db = {}
if m == "off" then db.battleShout = false end
wb.login({ saved = { RageboundDB = db } })
wb.advance(7)
local shout = wb.shown("RageboundBattleShoutFrame")
local card = wb.frame("RageboundBattleShoutFrame")
if m == "fresh" then
	wb.expect("nothing before it's learned", shout, false)
elseif m == "buffed" then
	wb.expect("shout up with 2 minutes left: no card", shout, false)
elseif m == "off" then
	wb.expect("turned off: no card", shout, false)
elseif m == "expiring" then
	wb.expect("card with 30 seconds or less left", shout, true)
	wb.check(card.statusText:GetText():find("left", 1, true), "counts down")
	wb.check(T.macroFor("Battle Shout"), "a click casts Battle Shout")
	wb.check(wb.printed("Battle Shout: %d+ sec left"), "the warning counts seconds under a minute")
	wb.check(not wb.printed("Battle Shout: 1 min left"), "not \"1 min\" with 20 seconds left")
	-- the Extras page: Ragebound has no group buff, so the buff key note doesn't promise one
	wb.slash("/rage")
	local opt = wb.ns.optionsState
	for i, pg in ipairs(opt.pages) do if pg.title == "Extras" then opt.Select(i) end end
	local text = ""
	for _, pg in ipairs(opt.pages) do
		if pg.title == "Extras" then
			for _, r in ipairs({ pg.frame:GetRegions() }) do if r.GetText and r:GetText() then text = text .. r:GetText() .. "|" end end
		end
	end
	wb.check(text:find("next thing a card asks for", 1, true) ~= nil, "the Extras note explains the key")
	wb.check(not text:find("group buff", 1, true), "and promises no group buff Ragebound doesn't have")
else
	wb.expect("card when missing", shout, true)
	wb.check(card.statusText:GetText():find("10 rage", 1, true), "says it costs rage")
	local want = m == "rank" and "Battle Shout (Rank 3)" or "Battle Shout"
	wb.check(T.macroFor("/cast [nocombat,@player] " .. want), "a click casts the best rank known")
end
