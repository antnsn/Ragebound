<!-- summary (CurseForge "Summary" field, at most 256 characters):
Warrior helper for WoW: Forever: a one-click Battle Shout card, a rage bar (horizontal or vertical), warnings for low or broken gear and low bandages, an optional card that puts your best stone on your weapon, and your Hearthstone beside the Escape menu.
-->

# Ragebound

**The warrior helper for World of Warcraft: Forever: your shout, gear and bandages, explained.**

Ragebound keeps Battle Shout up and your kit in order: a card when Battle Shout is missing or running out, a warning before your gear breaks, and a warning before your bandages run out.

**Full guide:** https://antnsn.github.io/Ragebound/

**Beta:** Ragebound is new. Spell and item IDs come from Classic and are checked on Forever before 0.1.0; tell us what doesn't work.

## Battle Shout
- A card when **Battle Shout** is missing or has 30 seconds left. Click it to cast the best rank you know.
- It costs 10 rage, so out of combat you may need to build rage first.

## Gear
- **Durability**: a card when any equipped item drops to 25% or less (you pick the percentage). It names the worst item, and turns red once something is broken.
- **Weapon stone** (off by default): a card when your main hand has no stone on it. Click it to use your best **sharpening stone** (axes, swords, daggers, polearms, fist weapons) or **weighted stone** (maces, staves).

## Bandages
- Says when you carry fewer than 5 bandages (you pick the number), once you know First Aid. Every cloth bandage counts.

## Rage bar
- **Your rage in a bar of its own**, with the number on it and a glow at full rage. Shown while you have rage or are in combat.
- **Horizontal or vertical**, movable and resizable like the cards.
- Painted in the Rage skin; a plain bar in the Blizzard and Flat skins.

## Travel
- **Press Escape**: beside the game menu you get your Hearthstone.

## Also in it
- **Buff key** (Extras page): out of combat, each press casts the next thing a card asks for.
- **Well Rested and Well Fed**: a countdown before they run out, with a sound if you like.
- **Carrot on a Stick** (Extras page, off by default): worn while you ride, in the trinket slot you pick; your own trinket goes back on when you get off. Not in instances, and never in combat.
- **Explained**: hover over a card or button for a plain-word explanation of what it does and why (can be turned off).
- **Your layout**: every frame can be moved, snapped to a grid and scaled (`/rage unlock`).
- **Three skins**: the warrior look (dark iron and blood red), Blizzard and Flat.
- Loads on warriors only.

## Commands
- `/rage`: open the options
- `/rage help`: list every command
- `/rage unlock`: show every frame so you can drag it into place
- `/rage lock`: lock the frames again
- `/rage reset`: put every frame back where it started
- `/rage grid [size]`: snap to a grid while moving, or set its size
- `/rage minimap`: show or hide the minimap button
- `/rage explain`: turn the plain-word explanations in tooltips on or off

## Ideas and contributions
- **Missing something?** New features are added on request: leave a comment here.
- **Feel free to contribute**: the code is on GitHub, https://github.com/antnsn/Ragebound (issues and pull requests welcome).
- **Want a Bound addon for another class?** The shared core, LibBound, has a guide and API reference: https://antnsn.github.io/LibBound/

## The Bound family
Ragebound is one of the Bound addons, one per class, built on the same core: Lightbound (paladin), Chronobound (mage), Stormbound (shaman), Packbound (hunter), Spiritbound (priest), Felbound (warlock), Dreambound (druid), Ragebound (warrior) and Shadowbound (rogue). They look like their class but work the same way, so if you know one, you know them all.

## Changelog
<!-- changelog:start -->
### 0.1.0 beta 5

- **Carrot on a Stick** (Extras page, off by default): put it on when you mount, in the trinket slot you pick, and your own trinket back when you get off. Not in instances; in combat it waits until the fight is over. From LibBound, the same as in Lightbound.
- The Extras page is tidier: the Well-Rested and Well Fed switches sit in one row each.

### 0.1.0 beta 4

- **Battle Shout in combat**: you shout in the fight, so the card now shows only in combat by default, says **Missing: 10 rage**, and glows once you have the rage. A shout cast mid-fight is seen through the cast (the game hides buffs in combat) and counted down from there. Untick **Only in combat** on the Buffs page for the old out-of-combat card.
- Built on the latest LibBound, the shared core of the Bound addons, with its small fixes. Published on CurseForge straight from GitHub now.

### 0.1.0 beta 3

- **Rage bar**: your rage in a bar of its own (Marius' painted bar with the axe head), the number on it, a glowing line at the fill's end and a glow at full rage. Horizontal or vertical, movable and resizable; settings on the new Rage bar page. The Blizzard and Flat skins get a plain bar.

### 0.1.0 beta 2

- The bandage card is called **Low on bandages** now: "Bandages running low" was cut off.
- The guide has screenshots now.

### 0.1.0 beta 1

- First test build: Battle Shout card (click to cast), durability warning that names the worst item (red when broken), optional weapon stone card (a click uses your best sharpening or weighted stone on the main hand), bandage count once you know First Aid, the Hearthstone beside the Escape menu, the buff key, Well-Rested and Well Fed, explanations, movable frames, Rage, Blizzard and Flat skins. Built on LibBound-1.0.
<!-- changelog:end -->
