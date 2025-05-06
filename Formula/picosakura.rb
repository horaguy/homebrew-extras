class Picosakura < Formula
  desc "MML Compiler Sakura - picosakura player rust version"
  homepage "https://github.com/kujirahand/picosakura-rust"
  url "https://github.com/kujirahand/picosakura-rust/archive/refs/tags/v0.1.37.tar.gz"
  sha256 "fb94c12f5466fa2a1e9e375a0da3655c40fd3852e3fa4cd6bf909d0b38ce4849"
  license "MIT"
  head "https://github.com/kujirahand/picosakura-rust.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "#{bin}/picosakura", "--help"
  end
end
