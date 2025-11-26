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
    dylibs = Dir["*.dylib"]

    # Remove code signatures first to avoid Team ID mismatch issues
    # This must be done before install_name_tool modifications
    # dylibs.each do |dylib|
    #   system "codesign", "--remove-signature", dylib
    # end

    # Install files
    lib.install dylibs
    bin.install "slangc"

    # Add rpath to executables pointing to lib directory
    system "install_name_tool", "-add_rpath", "#{lib}", "#{bin}/slangc"

    # Install slang modules
    pkgshare.install Dir["*.slang-module"]
  end

  test do
    system "#{bin}/slangc", "--version"
  end
end

