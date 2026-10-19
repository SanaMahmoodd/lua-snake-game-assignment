<div align="center">

# 🌸 Snake Game ✨
### A cute, pastel-inspired Snake game built with Lua + LÖVE2D

**🐍 Move · 🍓 Eat · ⭐ Score · 💖 Play again**

*Lua Game Programming Assignment · Core game patterns + modern Lua concepts*

</div>

---

## 💗 About the project

**Snake Game** is a desktop game created with **Lua** and the **LÖVE2D** framework. Guide the snake around the board, collect food to grow, and try to beat your saved high score—without hitting a wall or your own tail!

The project follows a modular design to demonstrate game state management, entity components, vector mathematics, keyboard commands, persistent scores, and an event system. Its interface uses a soft pink-and-purple palette with little sparkle details. ✨

## ✨ Features

- 🏠 **Menu and Playing states** — start a round from the main menu.
- 🐍 **Classic Snake gameplay** — continuous, grid-based movement and growth.
- 🍓 **Random food spawning** — food appears in an unoccupied cell.
- 💯 **Score tracking** — score increases whenever food is eaten.
- 🏆 **Persistent high score** — best score is saved and loaded across sessions.
- 💥 **Collision detection** — game over when the snake hits a wall or itself.
- 🎮 **Keyboard input system** — commands are bound through the Command Pattern.
- 📣 **Event notifications (bonus)** — the Observer Pattern announces `food_eaten` events.
- 🎀 **Pastel UI** — rounded shapes, gentle colors, and decorative sparkles.

## 🎮 Controls

| Key | Action |
| :-- | :-- |
| `Enter` | Start a game from the menu |
| `↑` / `W` | Move up |
| `↓` / `S` | Move down |
| `←` / `A` | Move left |
| `→` / `D` | Move right |
| `R` | Restart after Game Over |
| `Esc` | Return to menu; from the menu, quit |

> **Tip:** The snake moves automatically. Turn before reaching a wall, and remember that it cannot reverse directly into itself!

## 🛠️ Requirements

- **LÖVE2D 11.x** — to run the game: [love2d.org](https://love2d.org/)
- **Lua 5.4** — *only* to run the separate `<close>` demonstration and command-line tests
- A code editor such as **Visual Studio Code** (optional)

## 🚀 How to run

### Option A — Windows (drag and drop)

1. Download or clone this repository.
2. If downloaded as ZIP, extract it.
3. Locate the project folder containing `main.lua`.
4. Drag the **whole folder** onto `love.exe` (commonly located at `C:\Program Files\LOVE\love.exe`).
5. Press **Enter** in the game menu to start!

### Option B — Terminal

From the project folder, run:

```bash
love .
```

This requires `love` to be on your system's `PATH`. In Windows PowerShell, an alternative is:

```powershell
& "C:\Program Files\LOVE\love.exe" .
```

> **Important:** The main game must be run with **LÖVE2D**, not with `lua main.lua`, because it calls LÖVE APIs such as `love.graphics` and `love.window`.

## 📁 Project structure

```text
snake/
├── main.lua                   # Entry point and LÖVE callbacks
├── gamestate.lua              # Menu/Playing state manager
├── entity.lua                 # Entity and components
├── vector2.lua                # Vector math and metamethods
├── highscore.lua              # High score persistence in LÖVE
├── input.lua                  # Keyboard command bindings
├── snake_game.lua             # Snake, food, collision, and scoring
├── events.lua                 # Bonus: observer-style event system
├── states/
│   ├── menu_state.lua         # Menu screen
│   └── game_state.lua         # Playing screen
├── lua54_demo/
│   ├── highscore54.lua        # Lua 5.4 <close> example
│   └── demo.lua               # Demo runner
├── test_vector2.lua           # Vector2 checks
├── test_events.lua            # Event-system checks
└── README.md                  # This guide
```

*The outer folder can have a different name; the important part is keeping the Lua files and `states/` in the correct relative locations.*

## 🧠 Programming concepts demonstrated

| Assignment task | Implementation |
| :-- | :-- |
| **1.1 Game State Manager** | Switches between Menu and Playing; each state exposes `update()` and `draw()` |
| **1.2 Entity Components** | `position`, `movement`, and `renderer` components |
| **2.1 High Score** | Save/load in LÖVE; separate Lua 5.4 resource-management demo |
| **2.2 Vector2** | `__add`, `__eq`, and `__tostring` metamethods |
| **3.1 Core Game Logic** | Movement, food, growth, scoring, and collision detection |
| **3.2 Input Handling** | Command Pattern with `bind()` and `handleKey()` |
| **Bonus: Event System** | Observer Pattern with `subscribe()` and `emit()` |

### 🌟 Lua 5.4 compatibility note

The assignment also introduces **to-be-closed variables**, written as `local file <close> = ...` in **Lua 5.4**. **LÖVE 11.x uses LuaJIT**, which does not support that syntax directly.

For that reason:

- The **playable LÖVE game** uses `love.filesystem` in `highscore.lua` to save and load the high score.
- The **separate educational demonstration** in `lua54_demo/highscore54.lua` shows Lua 5.4's `<close>` feature using regular file I/O.

Run the demonstration with an installed Lua 5.4 interpreter:

```powershell
cd lua54_demo
lua demo.lua
```

This demonstrates the requested Lua feature **separately**; it does not mean `<close>` is used by the LÖVE runtime.

## 🧪 Quick tests

From the project root, use Lua 5.4 to test the standalone modules:

```powershell
lua test_vector2.lua
lua test_events.lua
```

Expected key results:

```text
Vector Addition: (11, 10)
Vector Equality: true
Vector String: (10, 10)
Event System Test: PASSED
```

For the complete game, also verify that the menu opens, controls work, eating increases the score, the high score survives reopening the game, collisions trigger Game Over, and the `food_eaten` event updates its on-screen message.

## 💌 Project notes

This project was developed as part of a **Lua Game Programming Assignment**. It combines the required gameplay mechanics with a modular code structure and a playful, pastel-inspired presentation.

<div align="center">

**Made with Lua, LÖVE2D & a little sparkle ✨💗**

</div>
