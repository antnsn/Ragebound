<!-- summary (CurseForge "Summary" field, at most 256 characters):
Warrior helper for WoW: Forever: a one-click Battle Shout card, warnings for low or broken gear and low bandages, an optional card that puts your best sharpening or weighted stone on your weapon, and your Hearthstone beside the Escape menu.
-->

# Ragebound

**The warrior helper for World of Warcraft: Forever: your shout, gear and bandages, explained.**

Ragebound keeps Battle Shout up and your kit in order: a card when Battle Shout is missing or running out, a warning before your gear breaks, and a warning before your bandages run out.

**Beta:** Ragebound is new. Spell and item IDs come from Classic and are checked on Forever before 0.1.0; tell us what doesn't work.

## Battle Shout
- A card when **Battle Shout** is missing or has 30 seconds left. Click it to cast the best rank you know.
- It costs 10 rage, so out of combat you may need to build rage first.

## Gear
- **Durability**: a card when any equipped item drops to 25% or less (you pick the percentage). It names the worst item, and turns red once something is broken.
- **Weapon stone** (off by default): a card when your main hand has no stone on it. Click it to use your best **sharpening stone** (axes, swords, daggers, polearms, fist weapons) or **weighted stone** (maces, staves).

## Bandages
- Says when you carry fewer than 5 bandages (you pick the number), once you know First Aid. Every cloth bandage counts.

## Travel
- **Press Escape**: beside the game menu you get your Hearthstone.

## Also in it
- **Buff key** (Extras page): out of combat, each press casts the next thing a card asks for.
- **Well Rested and Well Fed**: a countdown before they run out, with a sound if you like.
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
Ragebound is one of the Bound addons, one per class, built on the same core: Lightbound (paladin), Chronobound (mage), Stormbound (shaman), Packbound (hunter), Spiritbound (priest), Felbound (warlock), Dreambound (druid) and Ragebound (warrior). They look like their class but work the same way, so if you know one, you know them all.

## Changelog
<!-- changelog:start -->
### 0.1.0 beta 1

- First test build: Battle Shout card (click to cast), durability warning that names the worst item (red when broken), optional weapon stone card (a click uses your best sharpening or weighted stone on the main hand), bandage count once you know First Aid, the Hearthstone beside the Escape menu, the buff key, Well-Rested and Well Fed, explanations, movable frames, Rage, Blizzard and Flat skins. Built on LibBound-1.0.
<!-- changelog:end -->
