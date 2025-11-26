cask "shader-slang" do
  version "2025.23.1"
  sha256 "67d0c3191f6ee554f2827964ed98b2fa05f005c7f6ba601535bd9497f1ada487"

  url "https://github.com/shader-slang/slang/releases/download/v#{version}/slang-macos-dist-aarch64.zip"
  name "Shader Slang"
  desc "Slang shader compiler"
  homepage "https://github.com/shader-slang/slang"

  livecheck do
    url :stable
    strategy :github_latest
  end

  binary "slangc"
  binary "slangd"

  postflight do
    # Install libraries to Homebrew's lib directory
    lib_path = Pathname.new("/opt/homebrew")/"lib"
    lib_path.mkpath
    [
      "libgfx.0.#{version}.dylib",
      "libslang-compiler.0.#{version}.dylib",
      "libslang-glsl-module-#{version}.dylib",
      "libslang-glslang-#{version}.dylib",
      "libslang-llvm.dylib",
      "libslang-rt.0.#{version}.dylib",
    ].each do |dylib|
      system_command "/bin/cp",
                     args: ["-f", staged_path/dylib, lib_path],
                     sudo: false
    end

    # Install modules to Homebrew's share directory
    share_path = Pathname.new("/opt/homebrew")/"share"/"shader-slang"
    share_path.mkpath
    system_command "/bin/cp",
                   args: ["-f", staged_path/"neural.slang-module", share_path],
                   sudo: false
  end

  uninstall delete: [
    "/opt/homebrew/lib/libgfx.0.#{version}.dylib",
    "/opt/homebrew/lib/libslang-compiler.0.#{version}.dylib",
    "/opt/homebrew/lib/libslang-glsl-module-#{version}.dylib",
    "/opt/homebrew/lib/libslang-glslang-#{version}.dylib",
    "/opt/homebrew/lib/libslang-llvm.dylib",
    "/opt/homebrew/lib/libslang-rt.0.#{version}.dylib",
    "/opt/homebrew/share/shader-slang",
  ]
end
