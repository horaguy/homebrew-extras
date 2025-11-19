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

    # # Fix install_name for each dylib to use @rpath
    dylibs.each do |dylib|
      dylib_name = File.basename(dylib)
      system "install_name_tool", "-id", "@rpath/#{dylib_name}", dylib
    end

    # # Fix dylib references in executables to use @rpath
    # # Check and fix any absolute paths or build-time paths
    ["slangc"].each do |exe|
      # Get all library dependencies
      libs = `otool -L #{exe}`.lines.map(&:strip).grep(/\.dylib/)
      libs.each do |lib_line|
        # Extract the library path (before the first space or parenthesis)
        lib_path = lib_line.split.first
        next if lib_path.start_with?("@") # Already using @rpath or @loader_path
        next unless lib_path.include?(".dylib")

        dylib_name = File.basename(lib_path)
        # Change any absolute path to @rpath
        system "install_name_tool", "-change", lib_path, "@rpath/#{dylib_name}", exe
      end
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

