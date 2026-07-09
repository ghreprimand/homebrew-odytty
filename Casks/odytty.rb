# Canonical source for the `odytty` Homebrew cask.
#
# The tap (`ghreprimand/homebrew-odytty`) holds its own git repository; this
# copy is the upstream template. On each release tag the `homebrew` job in
# .github/workflows/release.yml stamps `version` and `sha256` from the published
# release, then pushes the updated cask (and the source-build formula) to the
# tap, the same pattern the `scoop` and `aur` jobs use for their channels.
#
# The cask installs the prebuilt, ad-hoc-signed `OdyTTY.app` (Apple Silicon /
# arm64) that the release workflow's macOS leg produces. The app carries an
# ad-hoc signature but is not notarized (no Apple Developer account is
# involved), so macOS quarantines the download and Gatekeeper would block the
# first launch. The postflight below clears the quarantine attribute from the
# installed app so it launches cleanly, which is the same one-time step a user
# would otherwise run by hand. Notarization would remove the need for it. Intel
# Macs use the source-build formula instead.
#
# The `sha256` below is a placeholder until the first release that publishes
# `odytty-<version>-macos-arm64.zip`; the auto-bump fills the real checksum.
cask "odytty" do
  version "0.8.2"
  sha256 "901a9021eaeb1cee4a60e2c36e4911cde442aa127b1ea9afd7cd9d3862b39e92"

  url "https://github.com/ghreprimand/odytty/releases/download/v#{version}/odytty-#{version}-macos-arm64.zip"
  name "OdyTTY"
  desc "Reliable, GPU-rendered terminal emulator with an OdysseyOS visual identity"
  homepage "https://github.com/ghreprimand/odytty"

  depends_on arch: :arm64
  depends_on macos: :big_sur

  app "OdyTTY.app"

  # OdyTTY.app is ad-hoc signed but not notarized, so macOS quarantines the
  # download and Gatekeeper blocks the first launch. Clear the quarantine flag
  # on the installed app so it launches without a warning. Tolerate a non-zero
  # exit (for example when the attribute is already absent) so a reinstall never
  # fails on this step.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-r", "-d", "com.apple.quarantine", "#{appdir}/OdyTTY.app"],
                   must_succeed: false
  end
end
