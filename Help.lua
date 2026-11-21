-- Every plain-word explanation in one place (tooltips show them while "Explain things" is on).
local _, ns = ...
if ns.disabled then return end

ns.Help = {
	battleShout = "Battle Shout raises the attack power of you and your party for 2 minutes and costs 10 rage. You shout it in the fight, so by default the card shows only in combat and glows once you have the rage.",
	durability = "Gear loses durability when you take hits, deal damage or die. A broken item (0%) gives none of its stats. Any blacksmith or armor and weapon vendor repairs it.",
	stone = "A sharpening stone (axes, swords, daggers, polearms, fist weapons) or weighted stone (maces and staves) adds damage to your main-hand weapon for 30 minutes. Blacksmiths make them; the Auction House sells them.",
	bandages = "A bandage heals you over a few seconds, out of combat or in a pause in the fight. Damage interrupts it. You make bandages with First Aid from cloth.",
	hearthstone = "Your Hearthstone takes you back to the inn you set it to. Talk to an innkeeper to change it.",
}
