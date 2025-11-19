class Slangc < Formula
  desc "Slang shader compiler"
  homepage "https://github.com/shader-slang/slang"
  url "https://github.com/shader-slang/slang/releases/download/v2025.22.1/slang-macos-dist-aarch64.zip"
  sha256 "946e59576b00b28ec34b36de9f77c216a319fc932d6e2efac315533631156892"
  head "https://github.com/shader-slang/slang.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  def install
    dylibs = Dir["*.dylib"]

    # Remove code signatures first to avoid Team ID mismatch issues
    # This must be done before install_name_tool modifications
    dylibs.each do |dylib|
      system "codesign", "--remove-signature", dylib
    end

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

