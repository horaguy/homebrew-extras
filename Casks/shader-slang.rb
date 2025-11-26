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

  postflight do
    # Install libraries to Homebrew's lib directory
    lib_path = Pathname.new(ENV["HOMEBREW_PREFIX"] || "/opt/homebrew")/"lib"
    lib_path.mkpath
    Dir.glob(staged_path/"*.dylib").each do |dylib|
      system_command "/bin/cp",
                     args: ["-f", dylib, lib_path],
                     sudo: false
    end

    # Install modules to Homebrew's share directory
    share_path = Pathname.new(ENV["HOMEBREW_PREFIX"] || "/opt/homebrew")/"share"/"shader-slang"
    share_path.mkpath
    Dir.glob(staged_path/"*.slang-module").each do |module_file|
      system_command "/bin/cp",
                     args: ["-f", module_file, share_path],
                     sudo: false
    end
  end
end
