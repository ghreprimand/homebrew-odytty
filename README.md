# OdyTTY Homebrew tap

A [Homebrew][brew] tap for [OdyTTY][odytty] — a reliable, GPU-rendered terminal
emulator with an OdysseyOS visual identity.

## Install

```sh
brew tap ghreprimand/odytty
brew install --cask odytty
```

The cask installs the prebuilt, ad-hoc-signed `OdyTTY.app` for Apple Silicon
(arm64). Installing through Homebrew strips the download's
`com.apple.quarantine` attribute, so the app launches without a Gatekeeper
warning — no Apple Developer account or notarization is involved.

### Intel Macs

The cask is arm64-only. On an Intel Mac, build the CLI binary from source with
the formula instead:

```sh
brew tap ghreprimand/odytty
brew install odytty
```

This compiles from the published release tarball (`rust` is pulled in as a build
dependency). A locally compiled binary is never quarantined, so it also launches
warning-free.

## Contents

- **`Casks/odytty.rb`** — the advertised path: the prebuilt arm64 `OdyTTY.app`.
- **`Formula/odytty.rb`** — the fallback: a source build of the CLI binary,
  usable on any supported macOS including Intel.

## Maintenance

These recipes are generated. Their upstream source of truth lives in the main
project at [`dist/homebrew/`][upstream]; the project's release workflow stamps
the version and checksum from each published release and pushes the result here
automatically. Edits should be made upstream, not in this repository.

[brew]: https://brew.sh
[odytty]: https://github.com/ghreprimand/odytty
[upstream]: https://github.com/ghreprimand/odytty/tree/master/dist/homebrew
