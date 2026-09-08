# Canonical CheckPt Studio Homebrew cask.
#
# This file is the source of truth for the cask published to the
# `lockdownmedia/homebrew-studio` tap. The `studio-release-publish.yml`
# workflow copies it into the tap (on first publish) and then rewrites the
# `version` + both `sha256` values from the release's `index.json` via
# `tools/release/update-homebrew-cask.js` on every subsequent publish.
#
# The URLs interpolate `#{version}` so a bump only ever touches the version
# line and the two sha256 literals — keeping the per-release diff minimal.
# See apps/studio/RELEASE.md for the tap + secret setup.
cask "checkpt-studio" do
  version "0.1.4-test.6"

  on_arm do
    sha256 "e4cf01c96064a10efcc017871e4de386fd26b60856147c806e159b9e38c7223f"

    url "https://downloads.checkpt.io/#{version}/darwin-aarch64/CheckPt%20Studio_#{version}_aarch64.dmg",
        verified: "downloads.checkpt.io/"
  end
  on_intel do
    sha256 "405f8af4f60258e8854cef9b5c20fdd99bc91380b715a74ac1adc22c20fd7c8e"

    url "https://downloads.checkpt.io/#{version}/darwin-x86_64/CheckPt%20Studio_#{version}_x64.dmg",
        verified: "downloads.checkpt.io/"
  end

  name "CheckPt Studio"
  desc "Local-first, multi-agent coding workspace"
  homepage "https://checkpt.io/"

  # Studio ships its own signed auto-updater (epic #315 / #318), so mark the
  # cask auto_updates and let livecheck track the published `index.json`
  # rather than parsing filenames off a directory listing.
  livecheck do
    url "https://downloads.checkpt.io/index.json"
    strategy :json do |json|
      json.dig("current", "version")
    end
  end

  auto_updates true
  depends_on macos: :catalina

  app "CheckPt Studio.app"

  zap trash: [
    "~/Library/Application Support/io.checkpt.studio",
    "~/Library/Caches/io.checkpt.studio",
    "~/Library/HTTPStorages/io.checkpt.studio",
    "~/Library/Preferences/io.checkpt.studio.plist",
    "~/Library/Saved Application State/io.checkpt.studio.savedState",
    "~/Library/WebKit/io.checkpt.studio",
  ]
end
