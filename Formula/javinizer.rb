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
  version "1.1.0"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    url "https://github.com/javinizer/javinizer-go/releases/download/v1.1.0/javinizer-darwin-universal"
    sha256 "acdcbe4cb53a36edaaba481ff3e164ae79282ace19d847d1a27fd0cefb4f2633"
  end

  on_linux do
    on_arm do
      url "https://github.com/javinizer/javinizer-go/releases/download/v1.1.0/javinizer-linux-arm64"
      sha256 "3c9394d1e1a9e8d495f5afc2aef48a4b2c493c7d42935ca393c7c04acccea973"
    end
    on_intel do
      url "https://github.com/javinizer/javinizer-go/releases/download/v1.1.0/javinizer-linux-amd64"
      sha256 "e1fc49bc86283ef9a0d0a69c8be853ff0e4e01d7bf8831f4bb6b0fcf8b0e97e2"
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
