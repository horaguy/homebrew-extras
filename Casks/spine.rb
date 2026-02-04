cask "spine" do
    version "4.2.43" # ?
    sha256 "d0168adfd761484bece8d158737a32702ea1f50504735fcdfeb451e1141c8f0d"

    url "https://jp.esotericsoftware.com/launcher/mac-arm"
    name "Spine"
    desc "2D skeletal animation software"
    homepage "https://esotericsoftware.com/"

    livecheck do
      skip "No version information available"
    end

    # dmgの中にpkgがある
    pkg "Spine Trial.pkg"

    # app "Spine.app"

    # zap trash: [
    #   "~/Library/Application Support/Spine",
    #   "~/Library/Logs/Spine",
    #   "~/Library/Preferences/com.esotericsoftware.spine.plist",
    #   "~/Library/Saved Application State/com.esotericsoftware.spine.savedState",
    # ]
  end
