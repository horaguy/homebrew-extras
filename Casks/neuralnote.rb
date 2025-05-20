cask "neuralnote" do
  version "v1.1.0"
  sha256 "67e6d08ffd6691cdb346ec49866b3765f83725e8bbc7f8470c5d26669c98ef74"

  url "https://github.com/DamRsn/NeuralNote/releases/download/#{version}/NeuralNote_Installer_Mac.pkg"
  name "NeuralNote"
  desc "Audio Plugin for Audio to MIDI transcription using deep learning"
  homepage "https://github.com/DamRsn/NeuralNote"

  app "NeuralNote.app"

  # # Remove quarantine attribute to allow unsigned app to run without security warnings
  # postflight do
  #   system_command "/usr/bin/xattr",
  #                  args: ["-d", "com.apple.quarantine", "#{staged_path}/AivisSpeech.app"],
  #                  sudo: true
  # end

  uninstall launchctl: "com.neuralnote.NeuralNote",
            quit:      "com.neuralnote.NeuralNote",
            pkgutil:   "com.neuralnote.NeuralNote"

  zap trash: [
    "~/Library/Application Support/NeuralNote",
    "~/Library/Logs/NeuralNote",
    "~/Library/Preferences/com.neuralnote.NeuralNote.plist",
    "~/Library/Saved Application State/com.neuralnote.NeuralNote.savedState",
  ]
end
