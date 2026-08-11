# Homebrew formula template for javinizer.
#
# Rendered by scripts/homebrew/render-formula.sh from a release's checksums.txt,
# then committed to javinizer/homebrew-tap as Formula/javinizer.rb by the
# update-homebrew-tap job in .github/workflows/cli-release.yml.
#
# javinizer ships prebuilt binaries (CGO/SQLite is statically linked into each
# release asset), so this formula installs a prebuilt binary per platform
# rather than building from source. The darwin asset is a universal binary, so
# both Apple Silicon and Intel macs use the same URL + sha256.
class Javinizer < Formula
  desc "JAV metadata scraper and organizer"
  homepage "https://github.com/javinizer/javinizer-go"
  version "1.5.1"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    url "https://github.com/javinizer/javinizer-go/releases/download/v1.5.1/javinizer-darwin-universal"
    sha256 "339c1d95d0ddab72f1bc05d6f63d407713cf4f8d291e2dfee192577cb5b97ace"
  end

  on_linux do
    on_arm do
      url "https://github.com/javinizer/javinizer-go/releases/download/v1.5.1/javinizer-linux-arm64"
      sha256 "bc934f8a541703badfd3f9b7c9361e2b462729fabb7182460b855f31d5447787"
    end
    on_intel do
      url "https://github.com/javinizer/javinizer-go/releases/download/v1.5.1/javinizer-linux-amd64"
      sha256 "6f2923f008e869f60c46bbc1c45fecb696a17700d5e6db2fde1254415f5c58be"
    end
  end

  def install
    on_macos do
      bin.install "javinizer-darwin-universal" => "javinizer"
    end
    on_linux do
      on_arm do
        bin.install "javinizer-linux-arm64" => "javinizer"
      end
      on_intel do
        bin.install "javinizer-linux-amd64" => "javinizer"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/javinizer version --short")
  end
end
