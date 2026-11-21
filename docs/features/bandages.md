---
title: Bandages
parent: Features
nav_order: 4
description: A card when you carry fewer than 5 bandages, once you know First Aid.
---

# Bandages

Bandages heal you between pulls, so running out hurts. Ragebound counts them for you.

## What it does

- **Running low.** When you carry fewer than 5 bandages, a **Bandages running low** card shows how many are left, for example `Bandages: 3`.
- **None left.** At 0 the count turns red.
- **Only with First Aid.** Until you know First Aid, there is no card.
- **Cloth bandages count.** Every bandage made from cloth counts, from Linen Bandage to Heavy Runecloth Bandage.
- **Out of combat only.** The card hides in combat and comes back after the fight.

The card goes away once you carry enough bandages again. It is a reminder only: clicking it does nothing.

## How to use it

1. Learn First Aid and carry bandages.
2. When the card shows, make or buy more.
3. Want a different number? Open `/rage`, page **Bandages**, and move the **Warn below** slider.

## Settings

In `/rage`, page **Bandages**:

| Setting | Default | What it does |
| --- | --- | --- |
| Warn when bandages run low | On | Turns the card on or off. |
| Warn below | 5 bandages | The card shows when you carry fewer than this, 1 to 40. |

## Good to know

**I have 5 bandages and no card shows.**
The card shows below the number you set. With the default of 5, it shows at 4 or fewer.

**Some of my bandages don't count.**
Only the ten cloth bandages count: Linen, Heavy Linen, Wool, Heavy Wool, Silk, Heavy Silk, Mageweave, Heavy Mageweave, Runecloth and Heavy Runecloth. Special bandages, such as Anti-Venom or battleground bandages, are left out.

**How do bandages work?**
A bandage heals you over a few seconds. Damage interrupts it, so use it out of combat or in a pause in the fight. You make bandages with First Aid from cloth.
