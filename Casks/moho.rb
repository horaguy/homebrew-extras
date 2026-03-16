cask "moho" do
  version "14.4"
  sha256 "abd8dd9f87c8cb1ef5fce90d393c4f7730e4c53cdfa404bef15f015c7e3e65c6"

  # Mirror Link (primary link is https://delivery.shopifyapps.com/-/b1b5e7614552eeac/15449ea520c87e08 but it's not work with CLI)
  url "https://dl.dropboxusercontent.com/scl/fi/nrz0dcufujy6093mk4g2h/Moho1440_Mac.dmg?rlkey=wo8ug7lalxmjfzdmcgzrh0gyl&st=q83hblkk"
  name "MOHO"
  desc "Vector based 2D Computer animation software"
  homepage "https://moho.lostmarble.com"

  livecheck do
    url "https://moho.lostmarble.com/pages/download"
    regex(/Current installer version - Moho (\d+(?:\.\d+)*)/i)
  end

  app "Moho.app"

  zap trash: [
    "~/Library/Application Scripts/com.lostmarble.moho.MohoThumbnailer",
    "~/Library/Containers/com.lostmarble.moho.MohoThumbnailer",
    "~/Library/Preferences/com.lostmarble.moho.plist",
  ]
end
