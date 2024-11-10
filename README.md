Mudlet scripts for Nukefire: Beyond Thunderdome

tdome.nukefire.org:4000

These scripts are a work-in-progress, but have been designed to be as "drop-in" as possible for anyone to use.
Most inter-profile communication is via Events - meaning you will automatically find the right profile for the action without hardcoding profile names.

Class-specific aliases, scripts, and triggers:

- Assassin
- Mutant
- Curist
- Slinger
- Samurai
- Ninja
- Knight
- Heretic
- Kaiju
- Voidstriker

General purpose aliases, scripts, triggers:

- Groups
- Combat
- Death / corpse retrieval
- Items / Inventory / Eq / Money
- Directions / navigation

Replacement for Mudlet's generic_mapper so that mapping works in Nukefire.

# Installation

To just get up and running with the scripts, it's best to download the pre-compiled Mudlet package.

Note that Mudlet doesn't enable MSDP support on profiles by default, which is required for these scripts to work.
So make sure to enable MSDP in the Settings->General section for each profile, and then reconnect to the game.

[Download Nukefire mudlet package](https://github.com/rparet/nukefire-mudlet/releases/latest)

# Developing / Making changes

If you make any customizations via Mudlet's native editor, be sure to move them out of the "nukefire" package directory
so that they won't be overwritten by future package updates.

See below for the non-Mudlet editor workflow using muddler.

Development workflow

- Clone this repo
- Install [muddler](https://github.com/demonnic/muddler)
- Optionally install [DeMuddler](https://github.com/Edru2/DeMuddler/) if you want to export your existing mudlet triggers, scripts, aliases, etc.

Hot reloads

- Install muddler's [Muddler.mpackage](https://github.com/demonnic/muddler/releases) to your profile(s)
- Add a small "CI" script to the muddler profile, to detect new builds and reload them. The simple version looks like this:

```
myCIhelper = myCIhelper or Muddler:new({
  path = "/path/to/your/copy/of/this/repo"
})
```

Builds

There's a `build.sh` script in the root directory that assumes muddler is located at

`../muddle-shadow-1.0.3/bin/muddle`

so either install it there, update that script, or write your script that calls muddle for building the package.

# Thanks

- Nukefire players and Imms - what an awesome nostalgia bomb
- demonnic - muddler / mudlet tech support
- Edru2 - demuddler made it much easier to get this package built
