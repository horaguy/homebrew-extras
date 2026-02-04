cask "live2d" do
    version "5.3.00"
    sha256 "0292e93216e0a24ab1065c69c4ded70b81d39d9f4b24d1ccbedd2b42c819459e"

    url "https://cubism.live2d.com/editor/bin/Live2D_Cubism_Setup_#{version}_arm64.pkg"
    name "Live2D Cubism Editor"
    desc "2D software to edit Live2D models"
    homepage "https://www.live2d.com/"

    livecheck do
      url "https://www.live2d.com/cubism/download/editor/"
      regex(/<span id="ver_mac" [^>]*>(\d+(?:\.\d+)*)\s*\(.*?\)<\/span>/)
    end

    pkg "Live2D_Cubism_Setup_#{version}_arm64.pkg"

    # /Applications/Live2D Cubism 5.3 のようなディレクトリがあるので、それを削除する。versionではなく /Applications/Live2D Cubism *を消した方が良い
    uninstall delete: "/Applications/Live2D Cubism *"
  end
