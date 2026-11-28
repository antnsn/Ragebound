-- Weapon stone card: LibBound's WeaponStone.lua (moved there from here, same settings). Warriors
-- get stones only; the settings sit on the Gear page.
local _, ns = ...
if ns.disabled then return end
LibStub("LibBound-1.0").InstallWeaponStone(ns)
