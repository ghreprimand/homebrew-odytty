# Canonical source for the `odytty` Homebrew source-build formula.
#
# The tap (`ghreprimand/homebrew-odytty`) holds its own git repository; this
# copy is the upstream template. On each release tag the `homebrew` job in
# .github/workflows/release.yml stamps the `url` version and `sha256` from the
# published release, then pushes the updated formula (and the cask) to the tap.
#
# This builds the CLI binary from the published GitHub release source tarball —
# the same `git archive` tarball the AUR package and the Release workflow use.
# A locally compiled binary is never quarantined, so it launches without a
# Gatekeeper warning on any supported macOS (including Intel), which is why the
# formula is the fallback for arches the prebuilt arm64 cask does not target.
# The `.app` bundle is the cask's job; the formula ships only the CLI binary.
class Odytty < Formula
  desc "Reliable, GPU-rendered terminal emulator with an OdysseyOS visual identity"
  homepage "https://github.com/ghreprimand/odytty"
  url "https://github.com/ghreprimand/odytty/releases/download/v0.9.2/odytty-0.9.2.tar.gz"
  sha256 "622a2110c143a6aa45de1768ede8e79ac4d107bda694bddb92718dd3281b076d"
  license "GPL-3.0-only"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "odytty", shell_output("#{bin}/odytty --version")
  end
end
