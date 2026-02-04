cask "moho" do
  version "14.4"
  sha256 "abd8dd9f87c8cb1ef5fce90d393c4f7730e4c53cdfa404bef15f015c7e3e65c6"

  # url "https://www.dropbox.com/scl/fi/nrz0dcufujy6093mk4g2h/Moho1440_Mac.dmg?rlkey=wo8ug7lalxmjfzdmcgzrh0gyl&st=q83hblkk&dl=1"
  url "https://delivery.shopifyapps.com/-/b1b5e7614552eeac/15449ea520c87e08/download",
    user_agent: :fake
  name "MOHO"
  desc "Vector based 2D Computer animation software"
  homepage "https://moho.lostmarble.com"

  app "Moho.app"

  zap trash: [
    "~/Library/Application\ Scripts/com.lostmarble.moho.MohoThumbnailer",
    "~/Library/Application\ Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.lostmarble.moho.sfl4",
    "~/Library/Containers/com.lostmarble.moho.MohoThumbnailer",
    "~/Library/Preferences/com.lostmarble.moho.plist",
  ]
end
