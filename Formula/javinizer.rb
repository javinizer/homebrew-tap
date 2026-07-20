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
  version "1.3.1"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    url "https://github.com/javinizer/javinizer-go/releases/download/v1.3.1/javinizer-darwin-universal"
    sha256 "263e4383e02068af44bd23042baf83282d2ea2a059f8d5d6b6b87c48d651c624"
  end

  on_linux do
    on_arm do
      url "https://github.com/javinizer/javinizer-go/releases/download/v1.3.1/javinizer-linux-arm64"
      sha256 "f0421689c369e4af874e3cf04034241ec22801c2a0769b0c39b475cecca17cdb"
    end
    on_intel do
      url "https://github.com/javinizer/javinizer-go/releases/download/v1.3.1/javinizer-linux-amd64"
      sha256 "4cf1d10a98f19740cbe83c7767a1784bd94049c7eedeb5643e56a9f78f26e51e"
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
