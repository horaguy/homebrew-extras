cask "aseprite" do
  version "1.3.17,388832112" # version,asset_id
  sha256 "54edab654452a2797ae5f701a91956c02f72e57f88a89a63ae282692d67330ba"

  # EULA of Aseprite: https://github.com/aseprite/aseprite/blob/main/EULA.txt
  # According to the EULA, we release built apps only in private repository. As a result, an personal access token is required.
  # - The personal access token should include permissions to access the private repository.
  # - A personal access token (classic) is needed to use across different owner/organizations.
  # - A name of the environment variable should be "HOMEBREW_*"
  url "https://api.github.com/repos/horaguy/aseprite-build/releases/assets/#{version.csv.second}",
    header: [
      "Authorization: token #{ENV["HOMEBREW_PRIVATE_TAP_GITHUB_TOKEN"]}",
      "Accept: application/octet-stream",
    ]

  name "Aseprite"
  desc "Animated sprite editor & pixel art tool (***PRIVATE CASK***)"
  homepage "https://www.aseprite.org/"

  livecheck do
    url "https://api.github.com/repos/horaguy/aseprite-build/releases/latest",
      header: [
        "Authorization: token #{ENV["HOMEBREW_PRIVATE_TAP_GITHUB_TOKEN"]}",
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
