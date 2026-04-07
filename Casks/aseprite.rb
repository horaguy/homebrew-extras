cask "aseprite" do
  version "1.3.17,390606522"
  sha256 "1e6d1348443fbc176322e10699efb7401bf08d22e8f034dd864fae8f688b92c8"

  # According to the EULA of Aseprite, we release built apps only in private repository.
  # - https://github.com/aseprite/aseprite/blob/main/EULA.txt
  # - The name of the environment variable should be "HOMEBREW_*"

  url "https://api.github.com/repos/horaguy/aseprite-build/releases/assets/#{version.csv.second}",
      header: [
        "Authorization: token #{ENV.fetch("HOMEBREW_PRIVATE_TAP_GITHUB_TOKEN", nil)}",
        "Accept: application/octet-stream",
      ]
  name "Aseprite"
  desc "Animated sprite editor & pixel art tool (***PRIVATE CASK***)"
  homepage "https://www.aseprite.org/"

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
