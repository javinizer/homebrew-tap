# Homebrew Cask template for the Javinizer desktop app (macOS).
#
# Rendered by scripts/homebrew/render-formula.sh from a release's checksums.txt,
# then committed to javinizer/homebrew-tap as Casks/javinizer-app.rb by the
# update-homebrew-tap job in .github/workflows/cli-release.yml.
#
# This is a Cask (not a Formula) because it ships a GUI .app bundle that belongs
# in /Applications, which is the idiomatic Homebrew vehicle for GUI apps. It is
# separate from Formula/javinizer.rb (the CLI) so both can coexist:
#   brew install javinizer          # CLI
#   brew install --cask javinizer-app   # clickable macOS app
#
# Casks are macOS-only (there is no on_linux block), so the Linux AppImage is
# distributed as a direct download from the Releases page instead — AppImages
# are self-contained and need no package manager.
#
# The release asset is a zip built with `ditto -c -k --keepParent`, so unzipping
# yields Javinizer.app/ at the top level, which `app "Javinizer.app"` installs.
cask "javinizer-app" do
  desc "JAV metadata scraper and organizer — desktop app"
  homepage "https://github.com/javinizer/javinizer-go"
  version "1.3.3"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  url "https://github.com/javinizer/javinizer-go/releases/download/v1.3.3/javinizer-desktop-macos-universal.zip"
  sha256 "8cd1c34d5914f411c69739c624c7127471528b0e2886017fe10a28f62986c63e"

  app "Javinizer.app"

  zap trash: [
    "~/Library/Application Support/Javinizer",
    "~/Library/Preferences/com.javinizer.javinizer.plist",
    "~/Library/Caches/Javinizer",
    "~/Library/Logs/Javinizer",
  ]

  caveats <<~EOS
    The Javinizer app is unsigned. On first launch macOS Gatekeeper may show:
      "Javinizer" cannot be opened because the developer cannot be verified.
    Right-click the app → Open → confirm (one-time), or strip the quarantine
    attribute:
      xattr -dr com.apple.quarantine /Applications/Javinizer.app
    See: https://github.com/javinizer/javinizer-go/blob/main/docs/17-desktop-app.md
  EOS
end
