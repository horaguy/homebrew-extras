class Picosakura < Formula
  desc "MML Compiler Sakura - picosakura player rust version"
  homepage "https://github.com/kujirahand/picosakura-rust"
  url "https://github.com/kujirahand/picosakura-rust/releases/download/0.1.37/mac-picosakura-pack.zip"
  sha256 "f1dc979fd30d0becc948227a267106a1226e4b25e02d311f9b744d88088fd836"
  license "MIT"
  head "https://github.com/kujirahand/picosakura-rust.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  def install
    bin.install "picosakura"
    bin.install "mml2wav"
    lib.install "libpicosakura.dylib"
    pkgshare.install "fonts"
  end

  test do
    system "#{bin}/picosakura", "--help"
  end
end
