cask "aivis-speech" do
  version "1.1.0-preview.3"
  sha256 "01d14fc1b34dea889d1a47465dcce38d96dba580b49d4b6cecd5332dc30b2142"

  url "https://github.com/Aivis-Project/AivisSpeech/releases/download/#{version}/AivisSpeech-macOS-arm64-#{version}.dmg",
      verified: "github.com/"
  name "Aivis Speech"
  desc "AI Voice Imitation System - Text to Speech Software"
  homepage "https://aivis-project.com/"

  livecheck do
    url "https://aivis-project.com/"
    regex(/AivisSpeech-macOS-arm64-(.*?)\.(?:dmg|zip)/i)
  end

  depends_on macos: ">= :ventura"

  app "AivisSpeech.app"

  # Remove quarantine attribute to allow unsigned app to run without security warnings
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-d", "com.apple.quarantine", "#{staged_path}/AivisSpeech.app"],
                   sudo: true
  end

  uninstall launchctl: "com.aivis-project.aivisspeech",
            quit:      "com.aivis-project.aivisspeech",
            pkgutil:   "com.aivis-project.aivisspeech"

  zap trash: [
    "~/Library/Application Support/AivisSpeech",
    "~/Library/Application Support/AivisSpeech-Engine",
    "~/Library/Saved Application State/com.aivis-project.aivisspeech.savedState",
  ]
end
