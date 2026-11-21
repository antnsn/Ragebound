--@moods: fresh missing buffed rank off expiring quiet combat rage cast talent ends options quietgone
-- Battle Shout: by default a card only in combat (when it's cast), missing or running out; the
-- old out-of-combat card ("Only in combat" off) for missing, rank and expiring
local T = dofile(wb.dir .. "/tests/_warrior.lua")
local m = wb.mood
local known = ({ fresh = {}, missing = { 6673 }, buffed = { 6673 }, rank = { 6673, 5242, 6192 },
	off = { 6673 }, expiring = { 6673 } })[m] or { 6673 }
T.warrior(known)
local s = wb.state
-- a different name for rank 3 shows which rank a click casts (the game's /cast by name does the same)
if m == "rank" then s.spells[6192] = "Battle Shout (Rank 3)" end
if m == "buffed" then s.auras.player = { wb.aura("Battle Shout", 6673, 120) } end
if m == "expiring" or m == "quiet" then s.auras.player = { wb.aura("Battle Shout", 6673, 20) } end
if m == "quietgone" then s.auras.player = { wb.aura("Well Fed", 19705, 900) } end
if m == "talent" then s.auras.player = { wb.aura("Battle Shout", 6673, 180) } end -- Booming Voice: 3 minutes
s.player.powerType, s.player.powerMax, s.player.power = 1, 100, 0
local db = {}
if m == "off" then db.battleShout = false end
if m == "missing" or m == "rank" or m == "expiring" then db.battleShoutCombat = false end
if m == "quietgone" then db.wellFedCombat, db.wellFedKeep = true, false end
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
elseif m == "quiet" then
	wb.expect("out of combat, 20 seconds left: no card (only in combat)", shout, false)
	wb.check(not wb.printed("Battle Shout: %d+ sec left"), "and no warning out of combat")
	wb.combat(true); wb.advance(1)
	wb.expect("the fight starts: the card", wb.shown("RageboundBattleShoutFrame"), true)
	wb.check(wb.printed("Battle Shout: %d+ sec left"), "with the warning now")
elseif m == "combat" or m == "rage" then
	wb.expect("missing out of combat: no card (only in combat)", shout, false)
	wb.combat(true); wb.advance(1)
	wb.expect("in combat: the card", wb.shown("RageboundBattleShoutFrame"), true)
	local text = card.statusText:GetText()
	wb.check(text:find("10 rage", 1, true), "says it costs rage")
	wb.check(not text:find("click", 1, true), "and no \"click\" (no casting from a card in combat)")
	if m == "combat" then
		wb.expect("no glow without the rage for it", card:IsGlowing(), false)
	else
		s.player.power = 15
		wb.fire("UNIT_POWER_FREQUENT", "player", "RAGE"); wb.advance(1)
		wb.expect("glows once you have 10 rage", card:IsGlowing(), true)
		s.player.power = 40; s.player.secretPower = true
		wb.fire("UNIT_POWER_FREQUENT", "player", "RAGE"); wb.advance(1)
		wb.expect("rage it can't read: glows (can't tell)", card:IsGlowing(), true)
		wb.expect("and no error", #wb.takeErrors(), 0)
	end
elseif m == "cast" or m == "talent" then
	wb.combat(true); wb.advance(1)
	if m == "talent" then
		s.auras.player = {}; wb.advance(181) -- ran out during the fight
		wb.expect("ran out in combat: the card", wb.shown("RageboundBattleShoutFrame"), true)
	end
	-- buffs can't be read in combat: the cast tells it the shout is up again
	wb.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "cast-1", 6673)
	wb.advance(1)
	wb.expect("shouted in combat: the card goes", wb.shown("RageboundBattleShoutFrame"), false)
	wb.advance(m == "talent" and 120 or 95)
	if m == "talent" then
		wb.expect("3-minute shout (seen before the fight): still quiet at 2 minutes", wb.shown("RageboundBattleShoutFrame"), false)
		wb.advance(35)
	end
	wb.expect("30 seconds left: the card again", wb.shown("RageboundBattleShoutFrame"), true)
	wb.check(card.statusText:GetText():find("left", 1, true), "counting down")
	wb.advance(30)
	wb.expect("run out: still the card", wb.shown("RageboundBattleShoutFrame"), true)
	wb.check(card.statusText:GetText():find("10 rage", 1, true), "missing again")
	wb.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "cast-2", wb.SECRET)
	wb.expect("a cast it can't read: no error", #wb.takeErrors(), 0)
elseif m == "ends" then
	wb.combat(true); wb.advance(1)
	wb.expect("in combat: the card", wb.shown("RageboundBattleShoutFrame"), true)
	wb.combat(false); wb.advance(1)
	wb.expect("the fight ends: the card goes", wb.shown("RageboundBattleShoutFrame"), false)
elseif m == "quietgone" then
	-- LibBound: "only in combat" also keeps the "is gone" line (sayGone) quiet out of combat
	s.auras.player = {}
	wb.fire("UNIT_AURA", "player"); wb.advance(1)
	wb.check(not wb.printed("Well Fed is gone"), "no \"is gone\" out of combat when only in combat")
elseif m == "options" then
	wb.expect("only in combat by default", wb.ns.db.battleShoutCombat, true)
	wb.ns.db.battleShoutCombat = false; wb.ns.UpdateBuffTimers(); wb.advance(1)
	wb.expect("turned off: the out-of-combat card again", wb.shown("RageboundBattleShoutFrame"), true)
	wb.check(card.statusText:GetText():find("click", 1, true), "with click to cast")
	wb.slash("/rage")
	local opt = wb.ns.optionsState
	local text = ""
	local function Collect(f)
		for _, r in ipairs({ f:GetRegions() }) do if r.GetText and r:GetText() then text = text .. r:GetText() .. "|" end end
		for _, c in ipairs({ f:GetChildren() }) do Collect(c) end
	end
	for i, pg in ipairs(opt.pages) do if pg.title == "Buffs" then opt.Select(i); Collect(pg.frame) end end
	wb.check(text:find("Only in combat", 1, true) ~= nil, "the Buffs page has the toggle")
else
	wb.expect("card when missing", shout, true)
	wb.check(card.statusText:GetText():find("10 rage", 1, true), "says it costs rage")
	local want = m == "rank" and "Battle Shout (Rank 3)" or "Battle Shout"
	wb.check(T.macroFor("/cast [nocombat,@player] " .. want), "a click casts the best rank known")
end
