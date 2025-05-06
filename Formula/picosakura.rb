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
    libexec.install "picosakura"
    libexec.install "mml2wav"
    lib.install "libpicosakura.dylib"
    pkgshare.install "fonts"

    # Wrapper script to add the default font path
    (bin/"picosakura").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/picosakura" -s "#{pkgshare}/fonts/TimGM6mb.sf2" "$@"
    EOS
    chmod 0755, bin/"picosakura"
    (bin/"mml2wav").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/mml2wav" -s "#{pkgshare}/fonts/TimGM6mb.sf2" "$@"
    EOS
    chmod 0755, bin/"mml2wav"
  end

  test do
    system "#{bin}/picosakura", "--help"
  end
end
