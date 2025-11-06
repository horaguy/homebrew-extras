cask "aivis-speech" do
  version "1.1.0-preview.4"
  sha256 "b072c324811049cdffe7f5cb2c0d1f3911c5afaaaf864a9566e011cd13ae2b16"

  url "https://github.com/Aivis-Project/AivisSpeech/releases/download/#{version}/AivisSpeech-macOS-arm64-#{version}.dmg",
      verified: "github.com/"
  name "Aivis Speech"
  desc "AI Voice Imitation System - Text to Speech Software"
  homepage "https://aivis-project.com/"

  livecheck do
    url "https://aivis-project.com/"
    regex(/AivisSpeech-macOS-arm64-(.*?)\.(?:dmg|zip)/i)
  end

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
    "~/Library/Logs/AivisSpeech",
    "~/Library/Preferences/com.aivis-project.aivisspeech.plist",
    "~/Library/Saved Application State/com.aivis-project.aivisspeech.savedState",
  ]
end
