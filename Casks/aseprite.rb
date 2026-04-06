cask "aseprite" do
  version "1.3.17,389808216"
  sha256 "13de96b38afe216591f2a4b961d08df682769add566d41374fbaa7f9e2e8d904"

  # According to the EULA of Aseprite, we release built apps only in private repository.
  # - https://github.com/aseprite/aseprite/blob/main/EULA.txt
  # - A personal access token (classic) is needed to use across different owner/organizations.
  # - The name of the environment variable should be "HOMEBREW_*"

  url "https://api.github.com/repos/horaguy/aseprite-build/releases/assets/#{version.csv.second}",
      header: [
        "Authorization: token #{ENV.fetch("HOMEBREW_PRIVATE_TAP_GITHUB_TOKEN", nil)}",
        "Accept: application/octet-stream",
      ]
  name "Aseprite"
  desc "Animated sprite editor & pixel art tool (***PRIVATE CASK***)"
  homepage "https://www.aseprite.org/"

  depends_on arch: :arm64

  livecheck do
    # Get latest tag and asset ID
    url "https://api.github.com/repos/horaguy/aseprite-build/releases/latest",
        header: [
          "Authorization: token #{ENV.fetch("HOMEBREW_PRIVATE_TAP_GITHUB_TOKEN", nil)}",
          "Accept: application/json",
        ]
    regex(/v?(\d+(?:\.\d+)+)/i)
    strategy :json do |json, regex|
      tag = json["tag_name"]&.then { |t| t.scan(regex).flatten.first }
      asset = json["assets"].find { |a| a["name"]&.end_with?("-macos-aarch64.zip") }
      "#{tag},#{asset["id"]}"
    end
  end

  app "Aseprite.app"

  postflight do
    # Remove quarantine attribute to allow unsigned app to run without security warnings
    system_command "xattr",
                   args: ["-dr", "com.apple.quarantine", "#{staged_path}/Aseprite.app"]
  end

  zap trash: [
    "~/Library/Application Scripts/org.aseprite.AsepriteThumbnailer",
    "~/Library/Application Support/Aseprite",
    "~/Library/Containers/org.aseprite.AsepriteThumbnailer",
  ]
end
