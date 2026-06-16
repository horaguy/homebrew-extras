cask "live2d" do
  version "5.3.03"
  sha256 "d0cbda2a4d41a7eb592fb2dfa7316d133c3161c006e081a74c4bfc2e31a03cdd"

  url "https://cubism.live2d.com/editor/bin/Live2D_Cubism_Setup_#{version}_arm64.pkg"
  name "Live2D Cubism Editor"
  desc "2D software to edit Live2D models"
  homepage "https://www.live2d.com/"

  livecheck do
    url "https://cubism.live2d.com/editor/js/download.js"
    regex(/LATEST_VERSION_MAC = "(\d+(?:\.\d+)*)"/)
  end

  depends_on :macos

  pkg "Live2D_Cubism_Setup_#{version}_arm64.pkg"

  uninstall delete: "/Applications/Live2D Cubism *"
end
