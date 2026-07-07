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
    sha256 "58128e13fc07cbdc2c45056f32ec1784a713e2b10207a4dea0c29c49e4dda628"
  end

  on_linux do
    on_arm do
      url "https://github.com/javinizer/javinizer-go/releases/download/v1.1.0/javinizer-linux-arm64"
      sha256 "9c19a1f20ecf595c9be29b204a59e022bcd06412595e2c4008b14abb50ec4a05"
    end
    on_intel do
      url "https://github.com/javinizer/javinizer-go/releases/download/v1.1.0/javinizer-linux-amd64"
      sha256 "1933319b62d51ca2f27bf6bd72ff9525d4a7160ecc9cddec8418d7ff11caddaf"
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
