<p align="center"><img src="Ragebound.png" width="180" alt="Ragebound: a battle axe across a red round shield"></p>

# Ragebound

A warrior helper for **WoW: Forever**, part of the Bound family: one addon per class on the same
core (Lightbound, Chronobound, Stormbound, Packbound, Spiritbound, Felbound, Dreambound, Ragebound).

- **Battle Shout**: a card when it is missing or running out. Click it to cast (it costs 10 rage).
- **Durability**: a card when an equipped item drops to 25% or less (you pick the percentage),
  in red once something is broken. It names the worst item.
- **Weapon stone** (off by default): a card when your main hand has no stone on it. Click it to use
  your best sharpening stone (blades) or weighted stone (maces, staves).
- **Bandages**: a card when you carry fewer than 5 bandages, once you know First Aid.
- **Travel**: press Escape, and beside the game menu you get your Hearthstone.
- **Buff key** (Extras page): out of combat, each press casts the next thing a card asks for.
- **Well-Rested and Well Fed** timers, plain-word explanations in tooltips, movable frames
  (`/rage unlock`), three skins (Rage, Blizzard, Flat).

Type `/rage` for the options, `/rage help` for the commands.

## Install

1. Open [Releases](https://github.com/antnsn/Ragebound/releases) and download
   `Ragebound-<version>.zip` (not the green "Code > Download ZIP" button).
2. Unzip it into `World of Warcraft/_forever_/Interface/AddOns/`, so you get `AddOns/Ragebound`.
3. Restart the game. Ragebound only loads on warriors.

## Development

Built on [LibBound](https://github.com/antnsn/LibBound), developed in the folder next to it.

```bash
tools/sync-libbound.sh
for f in *.lua; do luac5.1 -p "$f"; done
~/.luarocks/bin/luacheck .
wowbench check . && wowbench test .
wowbench pack . --set-version 0.1.0
python3 tools/make_media.py
```

## License

GPL-3.0-or-later: GNU General Public License, version 3 or (at your option) any later
version; see [LICENSE](LICENSE). LibBound-1.0 (in `Libs/LibBound`) is MIT, see its own LICENSE.
