cask "live2d" do
  version "5.3.04"
  sha256 "2ee1c534aeb3d671be8278d2a34d41f4d82acfb3fe1ed9216bec76d36f2fd75b"

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
