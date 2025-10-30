cask "nani" do
    version :latest
    sha256 :no_check

    url "https://nani-desktop.kiok.jp/artifacts/nani-mac-latest.dmg"
    name "Nani"
    desc "Nani is a brand-new AI translation tool."
    homepage "https://nani.now/ja"

    livecheck do
      skip "Uses a 'latest' URL without stable versioning"
    end

    app "Nani.app"

    zap trash: [
      "~/Library/Application Support/Nani",
      "~/Library/Logs/Nani",
      "~/Library/Preferences/jp.kiok.nani.plist",
    ]
end
