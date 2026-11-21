--@moods: warrior mage
local T = dofile(wb.dir .. "/tests/_warrior.lua")
if wb.mood == "warrior" then
	T.warrior({ 6673 })
	wb.login()
	wb.advance(7)
	wb.slash("/rage")
	wb.check(wb.shown("RageboundOptions"), "/rage opens the options")
	local titles = {}
	for _, p in ipairs(wb.ns.optionsState.pages) do titles[#titles + 1] = p.title end
	wb.expect("pages", table.concat(titles, ", "), "Buffs, Gear, Bandages, Rage bar, Travel, Extras, Skin")
	wb.check(wb.ns.travel ~= nil, "the travel panel (Hearthstone only) is installed")
else
	wb.state.player.classFile, wb.state.player.class = "MAGE", "Mage"
	wb.login()
	wb.slash("/rage")
	wb.check(wb.printed("only does something on a warrior"), "a mage is told why")
end
