--@moods: self nothing stone bind combat
-- the buff key (LibBound): each press casts the next thing needed, the top card first. Warriors
-- give no group buffs (Battle Shout reaches the party on its own).
local T = dofile(wb.dir .. "/tests/_warrior.lua")
local m = wb.mood
T.warrior({ 6673 })
local s = wb.state
if m ~= "self" then s.auras.player = { { name = "Battle Shout", spellId = 6673, duration = 120, expirationTime = 9999999, sourceUnit = "player" } } end
local db = { battleShoutCombat = false } -- the out-of-combat Battle Shout card, which the key casts
if m == "stone" then
	db.stone = true
	T.weapon(1000, 7)
	s.bags[2862] = 2
end
wb.login({ saved = { RageboundDB = db } })
local G = wb.G
local bound = {}
G.SetOverrideBindingClick = function(owner, prio, key, button) bound[key] = button end
G.ClearOverrideBindings = function() bound = {} end
G.UnitCanAssist = function(_, unit) return wb.unit(unit) ~= nil end -- not in the stub
wb.advance(7) -- the cards look every few seconds
local key = wb.frame("RageboundBuffKey")
wb.check(key ~= nil, "the buff key button exists")
local macro = key and key:GetAttribute("macrotext") or ""

if m == "self" then
	wb.expect("Battle Shout first (the top card)", macro, "/cast [nocombat,@player] Battle Shout")
elseif m == "stone" then
	wb.expect("then the stone card's click", macro, "/use item:2862\n/use 16")
elseif m == "nothing" then
	wb.expect("nothing to cast", macro, "")
	key:GetScript("PostClick")(key, "LeftButton", false)
	wb.check(wb.printed("nothing to buff"), "a press says there's nothing to do")
elseif m == "bind" then
	wb.ns.db.buffKey = "F"
	wb.ns.BindBuffKey()
	wb.expect("the key clicks the button", bound.F, "RageboundBuffKey")
	wb.ns.db.buffKey = nil
	wb.ns.BindBuffKey()
	wb.expect("and is let go when cleared", bound.F, nil)
elseif m == "combat" then
	wb.combat(true)
	wb.advance(2)
	wb.expect("the macro doesn't change in combat", key:GetAttribute("macrotext"), macro)
	wb.check(key:GetAttribute("type") ~= "macro", "and the key casts nothing in combat")
	wb.combat(false)
	wb.advance(1)
	wb.expect("it works again after the fight", key:GetAttribute("type"), "macro")
end
