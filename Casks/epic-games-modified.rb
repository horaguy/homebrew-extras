# Modified cask of Epic Games Launcher (https://github.com/Homebrew/homebrew-cask/blob/main/Casks/e/epic-games.rb)
# The original cask failed to verify the signature in Intel Mac in 19.0.0, so this cask is modified for Apple Silicon only.

cask "epic-games-modified" do
  version "19.0.0"
  sha256 "78e782ff73b3ddaa267b3d536af748b460200398133527cd199562955c1f184c"

  url "https://epicgames-download1.akamaized.net/Builds/UnrealEngineLauncher/Installers/Mac/EpicInstaller-#{version}.dmg",
      verified: "epicgames-download1.akamaized.net/"
  name "Epic Games Launcher (Modified)"
  desc "Launcher for *Epic Games* games"
  homepage "https://www.epicgames.com/"

  livecheck do
    url "https://launcher-public-service-prod06.ol.epicgames.com/launcher/api/installer/download/EpicGamesLauncher.dmg"
    strategy :header_match
  end

  auto_updates true
  depends_on arch: :arm64

  app "Epic Games Launcher.app"

  zap trash: [
    "~/Library/Application Support/Epic",
    "~/Library/Caches/com.epicgames.EpicGamesLauncher",
    "~/Library/Cookies/com.epicgames.EpicGamesLauncher.binarycookies",
    "~/Library/HTTPStorages/com.epicgames.CrashReportClient",
    "~/Library/HTTPStorages/com.epicgames.EpicGamesLauncher",
    "~/Library/Logs/Unreal Engine/EpicGamesLauncher",
    "~/Library/Preferences/Unreal Engine/EpicGamesLauncher",
    # Extra items which are not in the original cask:
    "~/Library/Services/UnrealEditorServices.app",
    "/Users/Shared/UnrealEngine",
  ]
end

