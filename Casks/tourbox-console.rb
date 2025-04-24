cask "tourbox-console" do
  version "5.8.3"
  sha256 "a09df292e4855705a5c2f22b7b2a37644807f8a3688c6f9e322056942369cc7b"

  url "https://tourbox-web-files.s3.us-west-2.amazonaws.com/prod/console/TourBoxInstall#{version}.zip",
      verified: "tourbox-web-files.s3.us-west-2.amazonaws.com/"
  name "TourBox Console"
  desc "Customizable controller for digital creators"
  homepage "https://www.tourboxtech.com/downloads/"

  # livecheck don't work for the download page, because it's rendered by JavaScript.
  livecheck do
    skip "No version information available"
  end

  depends_on macos: ">= :high_sierra"

  pkg "TourBoxInstall#{version}/TourBoxInstall#{version}.pkg"

  uninstall launchctl: "com.tourbox.ui.launch",
            quit:      "com.tourbox.ui.launch",
            pkgutil:   "com.tourbox.ui.launch"

  zap trash: [
    "~/Library/Application Support/TourBox Console BAK",
    "~/Library/Application Support/TourBox Console",
    "~/Library/Saved Application State/com.tourbox.ui.launch.savedState",
  ]
end
