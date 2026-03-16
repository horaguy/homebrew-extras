cask "live2d" do
  version "5.3.01"
  sha256 "4aa54245f508a01efc80995cd2ca3bd2a1e0153afa5787aa7ce29d2d893ba1af"

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
