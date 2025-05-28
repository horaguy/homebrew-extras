cask "neuralnote" do
  version "v1.1.0"
  sha256 "67e6d08ffd6691cdb346ec49866b3765f83725e8bbc7f8470c5d26669c98ef74"

  url "https://github.com/DamRsn/NeuralNote/releases/download/v#{version}/NeuralNote_Installer_Mac.pkg"
  name "NeuralNote"
  desc "Audio Plugin for Audio to MIDI transcription using deep learning"
  homepage "https://github.com/DamRsn/NeuralNote"

  pkg "NeuralNote_Installer_Mac.pkg"

  uninstall launchctl: "com.draudio.neuralnote",
            quit:      "com.draudio.neuralnote",
            pkgutil:   "com.draudio.neuralnote"

  zap trash: [
    "~/Library/Application Support/NeuralNote",
    "~/Library/Logs/NeuralNote",
    "~/Library/Preferences/com.draudio.neuralnote.plist",
    "~/Library/Saved Application State/com.draudio.neuralnote.savedState"
  ]
end
