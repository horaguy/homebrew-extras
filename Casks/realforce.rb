# https://github.com/Homebrew/homebrew-cask/blob/main/Casks/r/realforce.rb

cask "realforce" do
    version "4.1.1"
    sha256 "b05654444e7d73b01c8b22e8dbe5b71bf98c8c1a9d0f0122a38134256666de19"

    url "https://www.realforce.co.jp/support/download/software/mac/files/REALFORCE%20CONNECT%20Software_#{version.dots_to_hyphens}.pkg",
        verified: "https://www.realforce.co.jp/support/download/software/mac/files/",
        # user_agent: :fake,
        headers: {
            "Referer" => "https://www.realforce.co.jp/support/download/software/mac/files/",
            "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
        }
    name "REALFORCE for Mac"
    desc "Software for Realforce keyboards and mice"
    homepage "https://www.realforce.co.jp/"

    livecheck do
      url "https://www.realforce.co.jp/support/download/software/"
      regex(%r{href=.*?/REALFORCE\s*?CONNECT\s*?Software[._-](\d+(?:-\d+)+)\.pkg}i)
      strategy :page_match do |page, regex|
        page.scan(regex).map { |match| match[0].tr("-", ".") }
      end
    end

    pkg "REALFORCE CONNECT Software_#{version.dots_to_hyphens}.pkg"

    uninstall pkgutil: "com.topre.installpkg.realforce"

    zap trash: [
      "~/Library/Preferences/com.topre.RFRApplication.plist",
      "~/Library/Preferences/com.topre.RFSoftwareR3.plist",
      "~/Library/Saved Application State/com.topre.RFRApplication.savedState",
      "~/Library/Saved Application State/com.topre.RFSoftwareR3.savedState",
    ], rmdir: "~/Documents/Topre"
  end
