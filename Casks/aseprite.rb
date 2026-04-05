cask "aseprite" do
  version "1.3.17"
  sha256 "9c14489e8ef41341d740439a35382236320cf111e1ecb7fd9af84a2fe552f20c"

  # url "https://github.com/horaguy/aseprite-build/releases/download/v#{version}/Aseprite-v#{version}-macOS.zip",
  #     header: "Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}"
  url "https://api.github.com/repos/horaguy/aseprite-build/releases/assets/388832112",
  headers: {
    "Authorization" => "token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}"
    "Accept" => "application/octet-stream"
  }
  

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
end
