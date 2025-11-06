cask "melodyne" do
  version "5.4.2.006"
  sha256 "88d31b7eadf2a2c6c3eb931ae115706c25df2750c81cfedd76840a6ce0df9327"

  url "https://s3.eu-west-1.amazonaws.com/assets.celemony.com/Demos/Melodyne.#{version}-Demo.dmg"
  name "Melodyne"
  desc "Note-based audio editing software"
  homepage "https://www.celemony.com/melodyne"

  livecheck do
    url "https://services.celemony.com/cgi-bin/WebObjects/LicenseApp.woa/wa/demoRegistration?item=Melodyne5-Demo-Mac&language=en"
    regex(/Melodyne\.(\d+(?:\.\d+)*)-Demo\.dmg/)
  end

  pkg "Melodyne.#{version}.pkg"

  uninstall launchctl: "com.celemony.melodyne",
            quit:      "com.celemony.melodyne",
            script:    {
              executable: "/Applications/Melodyne 5/Melodyne Uninstaller.app/Contents/MacOS/Melodyne Uninstaller",
              sudo:      true,
            }
end
