---
title: Weapon stone
parent: Features
nav_order: 3
description: A card when your main hand has no stone on it. Click it to use your best one. Off by default.
---

# Weapon stone

A sharpening stone or weighted stone adds damage to your weapon for 30 minutes. Ragebound can tell you when it has worn off and put a new one on with a click. This card is off by default.

## What it does

![The weapon stone card]({{ '/screenshots/frames/stpoint.png' | relative_url }})

- **No stone.** When your main-hand weapon has no temporary enchant, a **Weapon stone** card shows up.
- **The right kind.** Ragebound looks at your main-hand weapon:

| Weapon | Stone |
| --- | --- |
| Axes, swords, daggers, polearms, fist weapons | Sharpening stone |
| Maces, staves | Weighted stone |

- **Your best stone.** It picks the best stone of that kind in your bags that your level allows: Dense, then Solid, Heavy, Coarse and Rough. The card says, for example, `Missing: click for Dense Sharpening Stone`, in red.
- **Click to use.** Out of combat, click the card and Ragebound uses that stone on your main hand.
- **No stone in your bags.** The card says `No sharpening stone in your bags` or `No weighted stone in your bags`, and a click does nothing.
- **Out of combat only.** The card hides in combat and comes back after the fight.

The card goes away as soon as the main hand has an enchant again.

## How to use it

1. Type `/rage`, open the **Gear** page and tick **Show when your main hand has no stone**.
2. Carry a few stones that fit your weapon.
3. When the card shows, click it out of combat.

## Settings

![The Gear page]({{ '/screenshots/options-gear.png' | relative_url }})

In `/rage`, page **Gear**, section **Weapon stone**:

| Setting | Default | What it does |
| --- | --- | --- |
| Show when your main hand has no stone | Off | Turns the card on or off. |

## Good to know

**What about my off-hand weapon?**
The card only checks the main hand. Put a stone on your off hand yourself.

**My weapon has an oil or another enchant on it, and the card doesn't show.**
Any temporary enchant on the main hand counts. The card only shows when there is none.

**No card with my main hand empty or a fishing pole in it.**
Only the weapon types in the table above take a stone, so other items never show the card.

**Where do I get stones?**
Blacksmiths make them, and the Auction House sells them.
