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
  version "1.6.4"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    url "https://github.com/javinizer/javinizer-go/releases/download/v1.6.4/javinizer-darwin-universal"
    sha256 "f422acf8862313f633608f80134af0c2360506b641526bfad643f72d8ba1036c"
  end

  on_linux do
    on_arm do
      url "https://github.com/javinizer/javinizer-go/releases/download/v1.6.4/javinizer-linux-arm64"
      sha256 "928e96d7c28dd48b397dc2b42cd9d1ae9c939b4c8fcb402b92d4c8d2af6057ea"
    end
    on_intel do
      url "https://github.com/javinizer/javinizer-go/releases/download/v1.6.4/javinizer-linux-amd64"
      sha256 "778f6884680166979e033a244e259293fe9f38f50070f57ed054b6968360fdae"
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
