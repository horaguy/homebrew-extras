cask "aseprite" do
  version "1.3.18.5,554126149"
  sha256 "2b5d2746feb204b67786488b5fcf9c045d0e10610439afb9d0e59739203ab2e8"

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
    url "https://github.com/horaguy/aseprite-build"
    regex(/v?(\d+(?:\.\d+)+)/i)
    strategy :github_latest do |json, regex|
      tag = json["tag_name"]&.then { |t| t[regex, 1] }
      asset = json["assets"]&.find { |a| a["name"]&.end_with?("-macos-aarch64.zip") }
      next if tag.blank? || asset.blank?

      "#{tag},#{asset["id"]}"
    end
  end

  depends_on :macos

  app "Aseprite.app"

  postflight_steps do
    # Remove quarantine attribute to allow unsigned app to run without security warnings
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{staged_path}}/Aseprite.app"],
        must_succeed: false
  end

  zap trash: [
    "~/Library/Application Scripts/org.aseprite.AsepriteThumbnailer",
    "~/Library/Application Support/Aseprite",
    "~/Library/Containers/org.aseprite.AsepriteThumbnailer",
  ]
end
