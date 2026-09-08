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
  version "0.1.4-test.7"

  on_arm do
    sha256 "5dbeab03e28b8446adde06eba9ab602af1ee989a4f44ec83c8ca193b892b2e5d"

    url "https://downloads.checkpt.io/#{version}/darwin-aarch64/CheckPt%20Studio_#{version}_aarch64.dmg",
        verified: "downloads.checkpt.io/"
  end
  on_intel do
    sha256 "699be258e82d904b3bb6569f6c3a6791e6c7132b824d95f02b68490ad7841570"

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
