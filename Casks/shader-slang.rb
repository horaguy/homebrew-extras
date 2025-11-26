# Compiling Slang takes a long time, so we use a pre-compiled binary.
# This is provided as a Cask since a Formulae aren’t suitable for pre-compiled binaries in Homebrew.
cask "shader-slang" do
  version "2025.23.1"
  sha256 "67d0c3191f6ee554f2827964ed98b2fa05f005c7f6ba601535bd9497f1ada487"

  url "https://github.com/shader-slang/slang/releases/download/v#{version}/slang-macos-dist-aarch64.zip"
  name "Shader Slang"
  desc "Slang shader compiler"
  homepage "https://github.com/shader-slang/slang"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "slangc"
  binary "slangd"

  artifact "libgfx.0.#{version}.dylib", target: "#{HOMEBREW_PREFIX}/lib/libgfx.0.#{version}.dylib"
  artifact "libslang-compiler.0.#{version}.dylib", target: "#{HOMEBREW_PREFIX}/lib/libslang-compiler.0.#{version}.dylib"
  artifact "libslang-glsl-module-#{version}.dylib", target: "#{HOMEBREW_PREFIX}/lib/libslang-glsl-module-#{version}.dylib"
  artifact "libslang-glslang-#{version}.dylib", target: "#{HOMEBREW_PREFIX}/lib/libslang-glslang-#{version}.dylib"
  artifact "libslang-llvm.dylib", target: "#{HOMEBREW_PREFIX}/lib/libslang-llvm.dylib"
  artifact "libslang-rt.0.#{version}.dylib", target: "#{HOMEBREW_PREFIX}/lib/libslang-rt.0.#{version}.dylib"
  artifact "neural.slang-module", target: "#{HOMEBREW_PREFIX}/share/shader-slang/neural.slang-module"

  zap trash: []
end
