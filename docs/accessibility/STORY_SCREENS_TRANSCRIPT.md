# Story And Screens Transcript

> Non-playable transcript for the preserved DieAI Flash game screens.

_Current as of: 2026-05-30_

---

## Purpose

This transcript gives a text-first walkthrough of the original game flow for users who cannot run
the Flash SWF, cannot use the Ruffle player, or need screen-reader-friendly context. It is not a
replacement for the playable build; it documents the preserved screens and controls that appear in
the 2018 game artifact.

## Controls

| Input              | Action                     |
| ------------------ | -------------------------- |
| `WASD`             | Move around the arena      |
| Arrow keys         | Alternate movement control |
| `Space`            | Attack or interact         |
| `Esc`              | Pause or restart           |
| Mouse click or Tab | Focus the Ruffle player    |

## Screen Transcript

### Start Screen

Screenshot: [start-screen.png](../../assets/images/start-screen.png)

The game opens on a black background with a cyan perspective grid. Large glowing text reads
`DIE, AI!` near the top of the screen. A dark blue `PLAY` prompt sits near the lower middle of the
grid. Selecting the prompt starts the story sequence.

### Opening Story

Screenshot: [intro-good.png](../../assets/images/intro-good.png)

White story text appears at the top: `The night before AICorp delivers their 1st order of Buddy
Bots to millions of homes around the world.` A platform labeled `SECTOR 12` sits below a billboard
advertising `ORDER YOUR BUDDY BOT TODAY!` with AICorp branding. Rows of Buddy Bots wait in bays on
both sides of the platform.

This establishes the launch-night setting: AICorp is preparing a mass delivery of household Buddy
Bots.

### Hacked Warning

Screenshot: [intro-hacked.png](../../assets/images/intro-hacked.png)

The story screen changes to an emergency warning. The top text reads: `SAVE THE WORLD, DR.
GIMMASTEIN! YOU'RE THE ONLY ONE STILL WORKING THIS LATE!!!` The billboard is now corrupted with red
text: `DESTROY THE HUMANS, BUDDY BOT TODAY.` The displayed Buddy Bot has red eyes, and the AICorp
branding is altered to `DIE aicorp`.

This establishes the conflict: the Buddy Bot launch has been compromised, and Dr. Gimmastein is the
only person available to stop it before the robots reach homes around the world.

### Level One

Screenshot: [level-one.png](../../assets/images/level-one.png)

Gameplay begins in `SECTOR 12`. The player character stands near the center of a factory-like
arena, above a dark exit marker labeled `-EXIT-`. The HUD shows a countdown timer in the upper left
and the score in the upper right. Enemy Buddy Bots approach from both lower sides of the arena, each
with a red health bar above it.

The playable goal is to move through the arena, attack or interact with threats, and stop the Buddy
Bots before the launch gets out of control.

### Game Over

Screenshot: [game-over.png](../../assets/images/game-over.png)

If the player loses, the game returns to the black background and cyan perspective grid. Large red
glowing text fills the center of the screen: `YOU LOSE!`

## Non-Playable Fallback Context

The modern wrapper uses Ruffle to emulate the original SWF in the browser. If the SWF cannot run,
the screenshots above preserve the main visual beats: start prompt, story setup, hacked warning,
first playable arena, controls, and loss state. Use the [README](../../README.md) for local-run
instructions and the [browser smoke checklist](../backlog/BROWSER_SMOKE_CHECKLIST.md) for wrapper
verification steps.
