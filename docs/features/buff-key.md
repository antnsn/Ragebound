---
title: Buff key
parent: Features
nav_order: 5
description: One key that does what a card asks for, out of combat.
---

# Buff key

Press one key, out of combat, and Ragebound does what a card is asking for: Battle Shout first, then the weapon stone.

## What it does

- Each press does **one** thing: the next thing that is needed.
- The order is always the same:
  1. **Battle Shout**, when its [card](battle-shout.html) offers a cast: Battle Shout has 30 seconds or less left, or it is missing and **When missing** is on.
  2. **Weapon stone**, when its [card](weapon-stone.html) offers a click: your main hand has no stone and a fitting stone is in your bags. The card is off by default.
- A press does the same as clicking the card.
- When there is nothing to do, a press says `nothing to buff right now.` in chat.

Ragebound has no group buff for the key. Battle Shout reaches your party when you cast it, so the key never targets other players.

## How to use it

1. Type `/rage` and open the **Extras** page.
2. Under **Buff key**, click the button next to **Key**, then press the key you want (for example a mouse button). Esc cancels.
3. Out of combat, press the key until it says there is nothing to buff.

## Settings

In `/rage`, page **Extras**, section **Buff key**:

| Setting | Default | What it does |
| --- | --- | --- |
| Key | Not set | The key itself. **Clear** removes it. |

What the key casts follows the cards. Turn off **Show** for Battle Shout on the **Buffs** page, or the weapon stone card on the **Gear** page, and the key skips it too.

## Good to know

**Does it work in combat?**
No. The game does not let addons cast for you in combat, so the key does nothing until combat ends.

**The Extras page talks about a group buff.**
That note is shared by all Bound addons. Ragebound has no group buff, so that step never happens.

**I pressed it and Battle Shout didn't go off.**
Battle Shout costs 10 rage. Build some rage first.

**My key does something else in the game too.**
Ragebound binds the key on top of your normal bindings while it is set. Pick a key you don't use for anything else, or **Clear** it to get the old binding back.
