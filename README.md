# Minecraft 26.1.2 Fabric Server (Docker)

A Minecraft **26.1.2** server with the **Fabric** mod loader, packaged for Docker. Everything needed (Java 25, the server jar, Fabric) is downloaded automatically on first start. No mods are preinstalled — the server starts clean.

## Quick start

The only requirement is [Docker](https://docs.docker.com/engine/install/).

```bash
git clone https://github.com/<your-username>/minecraft-fabric-docker.git
cd minecraft-fabric-docker
cp .env.example .env   # optional: tweak settings
./start.sh
```

The first start takes 2–5 minutes (~400 MB of downloads). Wait for `Done (...)! For help, type "help"` in the logs — the server is ready.

Connect in game: **Multiplayer → Add Server →** `localhost` (or the server IP).

> Ctrl+C only closes the log view; the server keeps running in the background.

## Management

| Action | Command |
|---|---|
| Start | `docker compose up -d` |
| Stop | `docker compose down` |
| Restart (after editing `.env`) | `docker compose restart` |
| Follow logs | `docker compose logs -f` |
| Server console (`stop`, `op`, `whitelist`...) | `docker attach minecraft-fabric`, detach with `Ctrl+p` `Ctrl+q` |
| Update the image | `docker compose pull && docker compose up -d` |

## Configuration

All settings live in **`.env`** (see comments there): RAM, difficulty, port, MOTD, offline mode, whitelist, etc. Apply changes with `docker compose restart`.

Server files live in **`data/`**:
- `data/world/` — the world (copy this folder to back it up)
- `data/server.properties` — fine-grained vanilla settings
- `data/ops.json`, `data/whitelist.json` — operators and whitelist

## Mods

No mods are installed by default. To add one:

1. Download the mod `.jar` for **Fabric + your Minecraft version** from [Modrinth](https://modrinth.com/mods).
2. Put it into the **`mods/`** folder.
3. `docker compose restart`.

Optional: let the container fetch mods from Modrinth automatically on startup by adding this to the `environment` section of `docker-compose.yml`:

```yaml
      MODRINTH_PROJECTS: fabric-api,lithium,ferrite-core
```

Project slugs are the short names from modrinth.com URLs. Versions matching the configured `VERSION` are resolved automatically.

> ⚠️ Clients usually need the same content mods as the server (server-side performance mods like Lithium are the exception).

## Playing with friends

1. Forward port **25565/TCP** on your router to this machine.
2. Friends connect using your public IP: `your.ip:25565`.
3. For cracked/offline clients set `ONLINE_MODE=FALSE` in `.env` (anyone can join with any nickname — protect the server with the whitelist).
4. Recommended: `ENABLE_WHITELIST=TRUE`, then add players via the console: `whitelist add nickname`.

## Troubleshooting

- **Port already in use** — change `PORT` in `.env`.
- **Out of memory** — lower `MEMORY` (minimum 2G) and/or `VIEW_DISTANCE`.
- **Crash loop after removing mods** — the world was created with mods that are no longer installed. Reset it: stop the server and delete (or move away) `data/world`, then start again.
- **Mod conflicts** — never keep two `.jar` files of the same mod; remove old versions.

## Credits

Built on the excellent [itzg/docker-minecraft-server](https://github.com/itzg/docker-minecraft-server) image. Minecraft is a game by Mojang; running a server requires accepting the [Minecraft EULA](https://aka.ms/MinecraftEULA) (done automatically via `EULA=TRUE`).

## License

[MIT](LICENSE)
