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
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"slangc"


    # dylibs = Dir["*.dylib"]

    # # Install files
    # lib.install dylibs
    # bin.install "slangc"
    # pkgshare.install Dir["*.slang-module"]

    # # Add rpath to executables pointing to lib directory
    # system "install_name_tool", "-add_rpath", "#{lib}", "#{bin}/slangc"

  end

  test do
    system "#{bin}/slangc", "--version"
  end
end

