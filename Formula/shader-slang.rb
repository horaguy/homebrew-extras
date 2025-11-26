class ShaderSlang < Formula
  desc "Slang shader compiler"
  homepage "https://github.com/shader-slang/slang"
  url "https://github.com/shader-slang/slang/releases/download/v2025.23.1/slang-macos-dist-aarch64.zip"
  sha256 "67d0c3191f6ee554f2827964ed98b2fa05f005c7f6ba601535bd9497f1ada487"
  head "https://github.com/shader-slang/slang.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  def install
    lib.install Dir["*.dylib"]
    bin.install "slangc"
    pkgshare.install Dir["*.slang-module"]
    # or
    # libexec.install Dir["*"]
    # bin.write_exec_script libexec/"slangc"
  end

  test do
    system "#{bin}/slangc", "--version"
  end
end

