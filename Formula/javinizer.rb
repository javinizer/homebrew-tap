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
  version "1.6.3"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    url "https://github.com/javinizer/javinizer-go/releases/download/v1.6.3/javinizer-darwin-universal"
    sha256 "a613cc4be9f96f3d922f596a7de30f4dfd1330f2d587b8bb330a4a837fa8c441"
  end

  on_linux do
    on_arm do
      url "https://github.com/javinizer/javinizer-go/releases/download/v1.6.3/javinizer-linux-arm64"
      sha256 "c183d25e6964a5963e989c8fabd9ed17e1a670a1ef823820e13e6f384ff5dc28"
    end
    on_intel do
      url "https://github.com/javinizer/javinizer-go/releases/download/v1.6.3/javinizer-linux-amd64"
      sha256 "28d74462abf267d56719dec8373e6487ecef50849e129aaffc29a8fe0de3d9fc"
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
