cask "aseprite" do
  version "1.3.17,388832112" # version,asset_id
  sha256 "54edab654452a2797ae5f701a91956c02f72e57f88a89a63ae282692d67330ba"

  url "https://api.github.com/repos/horaguy/aseprite-build/releases/assets/#{version.csv.second}",
    header: [
      "Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}",
      "Accept: application/octet-stream",
    ]

  name "Aseprite"
  desc "**PRIVATE CASK** Animated sprite editor & pixel art tool"
  homepage "https://www.aseprite.org/"

  livecheck do
    url "https://api.github.com/repos/horaguy/aseprite-build/releases/latest",
      header: [
        "Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}",
        "Accept: application/json",
      ]
    regex(/v?(\d+(?:\.\d+)+)/i)
    strategy :json do |json, regex|
      tag = json["tag_name"]&.scan(regex)&.flatten&.first
      asset = json["assets"].find { |a| a["name"]&.end_with?("macOS.zip") }
      "#{tag},#{asset["id"]}"
    end
  end

  app "Aseprite.app"

  postflight do
    system_command "xattr",
                   args: ["-dr", "com.apple.quarantine", "#{staged_path}/Aseprite.app"]
  end

  zap trash: [
    "~/Library/Application Scripts/org.aseprite.AsepriteThumbnailer",
    "~/Library/Application Support/Aseprite",
    "~/Library/Containers/org.aseprite.AsepriteThumbnailer",
  ]
end
