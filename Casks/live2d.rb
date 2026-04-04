cask "live2d" do
  version "5.3.02"
  sha256 "f8e222bc19505fb123a5b15cdb7922bc131a0e1b222b27da58171e7f7ba220f2"

  url "https://cubism.live2d.com/editor/bin/Live2D_Cubism_Setup_#{version}_arm64.pkg"
  name "Live2D Cubism Editor"
  desc "2D software to edit Live2D models"
  homepage "https://www.live2d.com/"

  livecheck do
    url "https://cubism.live2d.com/editor/js/download.js"
    regex(/LATEST_VERSION_MAC = "(\d+(?:\.\d+)*)"/)
  end

  pkg "Live2D_Cubism_Setup_#{version}_arm64.pkg"

  uninstall delete: "/Applications/Live2D Cubism *"
end
