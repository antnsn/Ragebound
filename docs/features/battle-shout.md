---
title: Battle Shout
parent: Features
nav_order: 1
description: A card in combat when Battle Shout is missing or has 30 seconds left. It glows once you have the rage.
---

# Battle Shout

Battle Shout lasts 2 minutes (3 with Booming Voice), so it drops all the time, and you shout it in the fight, where you have rage. Ragebound watches it on you. In combat, when it runs low or drops off, a card shows up and glows once you have the 10 rage for it.

## What it does

![The Battle Shout card]({{ '/screenshots/frames/battleshoutpoint.png' | relative_url }})

- **Only in combat.** By default the card and its messages show only during a fight. Out of combat, with no rage, it stays quiet.
- **Running out.** With 30 seconds left, a message shows in the middle of the screen and in chat (`Battle Shout: 25 sec left`), and a card appears with a countdown. If the fight starts with less than 30 seconds left, you get them as it starts.
- **Gone.** When Battle Shout is missing, the card shows **Missing: 10 rage**, faded, with the text in red.
- **Glows when you can shout.** In combat the card glows once you have 10 rage. Shout from your action bars: the game doesn't let addons cast for you in combat.
- **Shouted in the fight.** The game hides your buffs from addons in combat, so Ragebound sees your shout through the cast itself and counts down from there. It remembers how long your shout lasted the last time it could read it (2 or 3 minutes).
- **Out of combat (option).** Untick **Only in combat** and the card works out of combat as well: **Missing: click to cast (10 rage)**, click it to cast the highest rank you know, and once, while you are alive, a message says `Battle Shout is gone, rebuff`.
- **Any Battle Shout counts.** The card looks for Battle Shout on you, so one from another warrior counts too.
- **Only you.** Battle Shout also buffs your party, but the card only watches your own buffs.
- **Not learned, not shown.** Until you know Battle Shout, there is no card and no warning.

The card goes away as soon as Battle Shout is back on you.

## How to use it

1. Play as usual. Nothing shows out of combat, or while Battle Shout has more than 30 seconds left.
2. When the card shows in a fight and glows, shout.
3. Don't want it watched? Open `/rage`, page **Buffs**, and untick **Show** under Battle Shout.

To move the card, see [Frames and minimap](frames-and-minimap.html).

## Settings

![The Buffs page]({{ '/screenshots/options-buffs.png' | relative_url }})

In `/rage`, page **Buffs**, section **Battle Shout**:

| Setting | Default | What it does |
| --- | --- | --- |
| Show | On | Watches Battle Shout at all. Off means no card and no messages. |
| Sound | Off | Plays the raid warning sound with the messages. |
| When missing | On | Shows the **Missing** card when Battle Shout is gone (and, out of combat, the one-time "is gone, rebuff" message). Off: you only get the warning and countdown before it runs out. |
| Only in combat | On | The card and messages only during a fight. Off: also out of combat, where a click casts it. |

## Good to know

**Can I click the card in combat?**
No. The game does not let addons cast for you in combat. In combat the card is a reminder; shout from your action bars.

**I clicked the card out of combat and nothing happened.** (Only in combat off)
Battle Shout costs 10 rage. Out of combat you often have none, so build some rage first. The game then lets the cast through.

**Can I change the 30 seconds?**
No. The time is fixed. Well-Rested and Well Fed have a slider (see [Well-Rested and Well Fed](well-rested-and-well-fed.html)).

**I turned When missing off and now the card never shows for a missing Battle Shout.**
That is what the switch does. With it off, the card only shows for the last 30 seconds. The [buff key](buff-key.html) also skips a missing Battle Shout then, since it does what the cards ask for.

**Right after login or a loading screen, nothing shows for a few seconds.**
Ragebound waits about 5 seconds after you enter the world, so it doesn't call Battle Shout missing before the game has filled in your buffs.
