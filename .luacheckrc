-- luacheck config: run "luacheck ." from this folder (Lua 5.1, like the WoW client).
-- The real API list is wowbench's (wowbench check .); this one only lists what Ragebound uses.
std = "lua51"
max_line_length = false
ignore = { "212", "432" }
exclude_files = { "Libs/", "tests/", "tools/" }
read_globals = { "C_Item", "C_Timer", "CreateFrame", "GetInventoryItemDurability", "GetInventoryItemID", "GetInventoryItemTexture", "GetWeaponEnchantInfo", "InCombatLockdown", "LibStub", "UnitLevel", "UnitPower" }
