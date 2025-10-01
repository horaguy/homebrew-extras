cask "xppen" do
  version "4.0.12_250926,2025,09"
  sha256 "816e8342b33e0a8901056234ab0765eb0e0b49f3a386b68b7635ca305542cff7"

  url "https://download01.xp-pen.com/file/#{version.csv.second}/#{version.csv.third}/XPPenMac_#{version.csv.first}.zip",
      verified: "download01.xp-pen.com/"
  name "XPPen"
  desc "Driver for XP-Pen tablets"
  homepage "https://www.xp-pen.jp/download-978.html"

  livecheck do
    url "https://www.xp-pen.jp/download-978.html"
    strategy :page_match do |page|
      version = page[/class="name_text".*?>XPPenMac_(.*?)</, 1]
      date = Date.parse(page[/class="name_time".*?>(\w{3} \d{2},\d{4})/, 1])
      "#{version},#{date.year},#{date.month.to_s.rjust(2, "0")}"
    end
  end

  depends_on macos: ">= :high_sierra"

  pkg "XPPenMac_#{version.csv.third}.pkg"

  uninstall launchctl: "com.ugee.PenTablet",
            quit:      "com.ugee.PenTablet",
            script:    {
              # As described in the caveats, this uninstaller requires GUI operations.
              executable: "/Applications/XPPen/UninstallPenTablet.app/Contents/MacOS/UninstallPenTablet",
              sudo:       true,
            },
            pkgutil:   "com.ugee.PenTablet"

  zap trash: [
    "/Users/.localized/.XPPen",
    "/Users/root/.XPPen",
    "/Users/Shared/.XPPen",
    "~/.XPPen",
    "~/Library/Saved Application State/com.ugee.PenTablet.savedState/",
  ]

  caveats <<~EOS
    When you run 'brew uninstall xppen', UninstallPenTablet.app will ask for GUI operations.
    If you accidentally press Cancel in the GUI, please run 'brew uninstall --zap -f xppen' again.
  EOS
end
