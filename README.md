# javinizer homebrew tap

Homebrew tap for [javinizer](https://github.com/javinizer/javinizer-go) — a JAV metadata scraper and organizer (CLI, TUI, REST API, and web UI).

## Install

```bash
brew tap javinizer/homebrew-tap https://github.com/javinizer/homebrew-tap
brew trust --formula javinizer/tap/javinizer
brew install javinizer
```

> **Homebrew 6.0+** requires explicitly trusting third-party taps before installing from them. The `brew trust` step above is required once per tap. Alternatively, set `HOMEBREW_NO_REQUIRE_TAP_TRUST=1` to skip the check (less secure — not recommended).

Update to the latest stable release later:

```bash
brew upgrade javinizer
```

## How it works

The formula installs a **prebuilt binary** — CGO/SQLite is statically linked into each release asset, so Homebrew does not build from source or pull a SQLite dependency. On macOS it installs the universal binary (works on both Apple Silicon and Intel); on Linux it installs the platform-appropriate arm64/amd64 binary.

This tap is updated **automatically** on every stable release by the [`cli-release`](https://github.com/javinizer/javinizer-go/blob/main/.github/workflows/cli-release.yml) workflow in the main repo. Prereleases (`v1.0.0-rc.*`) never reach the tap, so `brew upgrade` never hands you a release candidate.

## Files

- `Formula/javinizer.rb` — the formula (auto-generated from `checksums.txt` on each stable release)

## Links

- Main repo: [javinizer/javinizer-go](https://github.com/javinizer/javinizer-go)
- Releases: [github.com/javinizer/javinizer-go/releases](https://github.com/javinizer/javinizer-go/releases)
- Issues: [github.com/javinizer/javinizer-go/issues](https://github.com/javinizer/javinizer-go/issues)
