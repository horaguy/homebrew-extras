cask "aseprite" do
  version "1.3.17"
  sha256 "54edab654452a2797ae5f701a91956c02f72e57f88a89a63ae282692d67330ba"

  # url "https://github.com/horaguy/aseprite-build/releases/download/v#{version}/Aseprite-v#{version}-macOS.zip",
  #     header: "Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}"
  # url "https://#{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}@api.github.com/repos/horaguy/aseprite-build/releases/assets/388832112",
  #   header: "Accept: application/octet-stream"
  url "https://api.github.com/repos/horaguy/aseprite-build/releases/assets/388832112",
    header: [
      "Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}",
      "Accept: application/octet-stream",
    ]

  name "Aseprite"
  desc "Animated sprite editor & pixel art tool"
  homepage "https://www.aseprite.org/"

  livecheck do
    url "https://api.github.com/repos/horaguy/aseprite-build/releases/latest"
    regex(/v?(\d+(?:\.\d+)+)/i)
    strategy :json do |json, regex|
      json["tag_name"]&.scan(regex)&.flatten
    end
  end

  app "Aseprite.app"

  zap trash: [
    "~/Library/Application Scripts/org.aseprite.AsepriteThumbnailer",
    "~/Library/Application Support/Aseprite",
    "~/Library/Containers/org.aseprite.AsepriteThumbnailer",
  ]
end
