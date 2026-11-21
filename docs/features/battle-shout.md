---
title: Battle Shout
parent: Features
nav_order: 1
description: A card when Battle Shout is missing or has 30 seconds left. Click it to cast.
---

# Battle Shout

Battle Shout lasts 2 minutes, so it drops all the time. Ragebound watches it on you. When it runs low or drops off, a card shows up, and one click puts it back.

## What it does

![The Battle Shout card]({{ '/screenshots/frames/battleshoutpoint.png' | relative_url }})

- **Running out.** With 30 seconds left, a message shows in the middle of the screen and in chat, and a card appears with a countdown. The message rounds up to whole minutes, so it reads `Battle Shout: 1 min left`.
- **Gone.** When Battle Shout is missing, the card shows **Missing: click to cast (10 rage)**, faded, with the text in red. Once, out of combat and while you are alive, a message says `Battle Shout is gone, rebuff`.
- **Click to cast.** Out of combat, click the card and Ragebound casts the highest rank of Battle Shout you know.
- **Any Battle Shout counts.** The card looks for Battle Shout on you, so one from another warrior counts too.
- **Only you.** Battle Shout also buffs your party, but the card only watches your own buffs.
- **Not learned, not shown.** Until you know Battle Shout, there is no card and no warning.

The card goes away as soon as Battle Shout is back on you.

## How to use it

1. Play as usual. Nothing shows while Battle Shout has more than 30 seconds left.
2. When the card shows, click it out of combat. Hover over it first if you want to see what it will cast.
3. Don't want it watched? Open `/rage`, page **Buffs**, and untick **Show** under Battle Shout.

To move the card, see [Frames and minimap](frames-and-minimap.html).

## Settings

![The Buffs page]({{ '/screenshots/options-buffs.png' | relative_url }})

In `/rage`, page **Buffs**, section **Battle Shout**:

| Setting | Default | What it does |
| --- | --- | --- |
| Show | On | Watches Battle Shout at all. Off means no card and no messages. |
| Sound | Off | Plays the raid warning sound with the messages. |
| When missing | On | Shows the **Missing** card and the one-time "is gone, rebuff" message when Battle Shout is gone. Off: you only get the warning and countdown before it runs out. |

## Good to know

**I clicked the card and nothing happened.**
Battle Shout costs 10 rage. Out of combat you often have none, so build some rage first, for example by attacking something. The game then lets the cast through.

**Can I click the card in combat?**
No. The game does not let addons cast for you in combat, so the click only works out of combat. The card stays visible, so you know what to do after the fight.

**Can I change the 30 seconds?**
No. The time is fixed. Well-Rested and Well Fed have a slider (see [Well-Rested and Well Fed](well-rested-and-well-fed.html)).

**The message says 1 min left, but the countdown says 0:30.**
The message rounds to whole minutes and never shows less than 1. The countdown on the card shows the real time left.

**I turned When missing off and now the card never shows for a missing Battle Shout.**
That is what the switch does. With it off, the card only shows for the last 30 seconds. The [buff key](buff-key.html) also skips a missing Battle Shout then, since it does what the cards ask for.

**Right after login or a loading screen, nothing shows for a few seconds.**
Ragebound waits about 5 seconds after you enter the world, so it doesn't call Battle Shout missing before the game has filled in your buffs.
