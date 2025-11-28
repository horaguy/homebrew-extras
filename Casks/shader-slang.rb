# Compiling Slang takes a long time, so we use a pre-compiled binary.
# This is provided as a Cask since a Formulae aren’t suitable for pre-compiled binaries in Homebrew.
cask "shader-slang" do
  version "2025.23.1"
  sha256 "c1b079af663dda7daf5c8dc93fa99049bf47b10d85607766ddee3d445abc00e5"

  url "https://github.com/shader-slang/slang/releases/download/v#{version}/slang-#{version}-macos-aarch64.zip"
  name "Shader Slang"
  desc "Slang shader compiler"
  homepage "https://github.com/shader-slang/slang"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "bin/slangc"
  binary "bin/slangd"
  binary "bin/slangi"

  artifact "lib/libgfx.0.#{version}.dylib", target: "#{HOMEBREW_PREFIX}/lib/libgfx.0.#{version}.dylib"
  artifact "lib/libslang-compiler.0.#{version}.dylib", target: "#{HOMEBREW_PREFIX}/lib/libslang-compiler.0.#{version}.dylib"
  artifact "lib/libslang-glsl-module-#{version}.dylib", target: "#{HOMEBREW_PREFIX}/lib/libslang-glsl-module-#{version}.dylib"
  artifact "lib/libslang-glslang-#{version}.dylib", target: "#{HOMEBREW_PREFIX}/lib/libslang-glslang-#{version}.dylib"
  artifact "lib/libslang-llvm.dylib", target: "#{HOMEBREW_PREFIX}/lib/libslang-llvm.dylib"
  artifact "lib/libslang-rt.0.#{version}.dylib", target: "#{HOMEBREW_PREFIX}/lib/libslang-rt.0.#{version}.dylib"
  artifact "lib/slang-standard-module-#{version}/neural.slang-module", target: "#{HOMEBREW_PREFIX}/share/shader-slang/neural.slang-module"

  zap trash: []
end
