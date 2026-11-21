---
title: Gear durability
parent: Features
nav_order: 2
description: A card when an equipped item is worn down, in red once something is broken.
---

# Gear durability

Gear wears down as you fight and die. Ragebound tells you when an item gets low, before it breaks.

## What it does

![The gear card]({{ '/screenshots/frames/dupoint.png' | relative_url }})

- **Worn down.** When any equipped item drops to 25% durability or less, a **Repair your gear** card shows up.
- **Names the worst item.** The card shows the item with the lowest durability and its percentage, for example `Legs 18%`. The icon is that item's own icon.
- **Broken.** At 0% the card says, for example, `Chest is broken`, in red.
- **Out of combat only.** The card hides in combat and comes back after the fight.
- It checks the slots that can lose durability: head, shoulders, chest, waist, legs, feet, wrists, hands, back, main hand, off hand and ranged.

The card goes away once every item is above the warning percentage again. It is a reminder only: clicking it does nothing.

## How to use it

1. Play as usual.
2. When the card shows, visit a repair vendor.
3. Want an earlier or later warning? Open `/rage`, page **Gear**, and move the **Warn at** slider.

## Settings

![The Gear page]({{ '/screenshots/options-gear.png' | relative_url }})

In `/rage`, page **Gear**, section **Durability**:

| Setting | Default | What it does |
| --- | --- | --- |
| Warn when an item's durability runs low | On | Turns the card on or off. |
| Warn at | 25% | The card shows when an item is at this percentage or lower, 5% to 75%. |

## Good to know

**Does it check the gear in my bags?**
No. Only what you are wearing.

**Why does the card vanish when I pull?**
On purpose. It only shows out of combat, so it doesn't get in the way of the fight.

**What does a broken item do?**
It gives none of its stats until you repair it. Any blacksmith or armor and weapon vendor repairs it.
