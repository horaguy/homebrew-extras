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
    # Save original binaries
    original_binary = "picosakura"
    original_mml2wav = "mml2wav"
    
    # Create wrapper scripts
    (bin/"picosakura").write <<~EOS
      #!/bin/bash
      cd "#{pkgshare}"
      exec "#{pkgshare}/#{original_binary}" "$@"
    EOS
    (bin/"picosakura").chmod 0755

    (bin/"mml2wav").write <<~EOS
      #!/bin/bash
      cd "#{pkgshare}"
      exec "#{pkgshare}/#{original_mml2wav}" "$@"
    EOS
    (bin/"mml2wav").chmod 0755

    # Move original files to pkgshare
    pkgshare.install original_binary
    pkgshare.install original_mml2wav
    lib.install "libpicosakura.dylib"
    pkgshare.install "fonts"
  end

  test do
    system "#{bin}/picosakura", "--help"
  end
end
