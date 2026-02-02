# RW-AntiCheat v5.0 Changelog

## New Features
- **Heartbeat System**: Implemented a server-client heartbeat to detect if a client stops responding (e.g., from resource stopping or network tampering).
- **OCR / Screenshot System**: Added support for capturing screenshots upon ban/detection using `screenshot-basic` and sending them to a Discord webhook.
- **Anti Silent Aim**: Added vector-based detection for silent aim (bullet impact vs camera view angle).
- **Robust Anti-Spawn**: Completely rewrote the entity spawn protection. It now uses `entityCreating` to block entities *before* they spawn, and correctly distinguishes between Peds, Vehicles, and Objects using `GetEntityType`.
- **Source Verification**: Added specific checks for `GetEntityScript` to determine if an entity was created by a legitimate resource or by a menu/injector.
- **Optimization**: Converted blacklist lookups from O(n) loop to O(1) hash map, significantly reducing server CPU time for every entity spawn event.
- **Anti-Noclip**: Added client-side detection for abnormal distance traveled (teleport/speed/noclip) while on foot.
- **Anti-Damage Modifier**: Added checks for abnormal weapon damage (e.g. killing in 1 shot with a pistol through huge damage multipliers).
- **Anti-Voice Spoofing**: Implemented advanced checks (Dead, Invisible, Spectating) for players using voice chat to prevent spoofing or trolling.
- **Anti-Give/Remove Weapon**: Secured weapon events serverside. Now blocks weapons given without "pickup" properties (common in menus) and prevents unauthorized weapon removal.
- **Anti-Change Outfit**: Tracks player model changes to detect unauthorized skin switching.
- **Input Scanner**: Filters chat inputs for malicious strings (XSS vectors, links) effectively acting as a clipboard/input sanitizer.
- **Deep Anti-Resource Manipulation**: Implemented a comprehensive 2-way verification system. Client periodically reports all running resources. Server verifies this list against the server-side state. Detects both **Injection** (Client has extra resource) and **Bypass** (Client stopped valid resource).
- **Global Variable Scanner**: Checks the Lua environment (`_G`) for variables injected by known cheats like **Eulen**, **Kazo**, **Macho**, **Susano**, **HamMafia**, **Lynx**, and others.
- **Specific Menu Signatures**: Added texture dictionary detection for Kazo, Macho, Susano, HamMafia, and Eulen to the visual scanner.
- **Anti-Overlay/Streamproof**: Detects suspicious resolution changes often caused by external overlays or "streamproof" injection toggles.
- **Anti-Entity Coords**: Server-side speed and teleport monitor for vehicles. Detects vehicle flying or teleporting across the map.
- **Anti-Spoof Projectile**: Checks the origin of shots. If a player hits a target from an impossible distance (Magic Bullet), it is blocked.
- **Entity Security**: Advanced `entityCreating` filtering to prevent unauthorized entity spawns.

## Improvements
- **Detection Optimization**: Completely rewrote the client-side detection loops. Instead of a single monolithic loop that blocked execution (causing checks to run only once every few seconds), detections are now split into appropriate threads (Fast, Medium, Slow). This makes detection instant and prevents FPS drops.
- **Code Cleanup**: Removed thousands of lines of redundant comments, unused code, and legacy checks that were no longer relevant.
- **Logic Fixes**: Fixed a critical bug in `ProtectPoliceEvent` and `ProtectAmbulanceEvent` where the check logic would always evaluate to true (banning innocent players).
- **Reduced Network Spam**: Optimized the heartbeat and resource check intervals to reduce network traffic.
- **Refactoring**: Cleaned up duplicate event handlers in `server.lua`.
- **Configuration**: Added detailed configuration options for all new features in `config.lua`.
- **Performance**: Optimized the entity creation check to reduce server load by blocking invalid entities earlier in the pipeline.

## Fixes
- Fixed legacy `entityCreated` logic that could potentially ban the wrong user or fail to delete entities in time.
- Corrected type checking for entities (previously relied solely on model hashes which could be ambiguous).
