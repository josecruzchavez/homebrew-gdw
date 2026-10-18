cask "gdw-mirror" do
  version "0.2.1"

  on_arm do
    sha256 "6868f20ef2b1f9e4b0c7c4079120c39a08bcdc549fc72e7f04db8ac4e64a5132"
    url "https://github.com/josecruzchavez/gdw-mirror/releases/download/v#{version}/GDW-Mirror-Host-#{version}-arm64.zip"
  end

  on_intel do
    sha256 "811b538e009da4684583d7e1517950e8f8c1ddfd47df96d6a569b0d1aa0e7233"
    url "https://github.com/josecruzchavez/gdw-mirror/releases/download/v#{version}/GDW-Mirror-Host-#{version}-x64.zip"
  end

  name "GDW Mirror Host"
  desc "Screen mirror from a Mac to Windows over the local network"
  homepage "https://mirror.gdw.mx/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "GDW Mirror Host.app"

  zap trash: [
    "~/Library/Application Support/GDW Mirror",
    "~/Library/Application Support/com.gdw.mirror.host",
    "~/Library/Caches/GDW Mirror",
    "~/Library/Caches/com.gdw.mirror.host",
    "~/Library/Preferences/com.gdw.mirror.host.plist",
    "~/Library/Saved Application State/com.gdw.mirror.host.savedState",
  ]

  caveats <<~EOS
    GDW Mirror Host runs from the menu bar: after installing, look for the
    display icon next to the clock. The first time you press "Share screen",
    macOS will ask for Screen Recording permission.

    The app is ad-hoc signed, not notarized, and Homebrew quarantines cask
    downloads, so macOS blocks the first launch. Approve it once in
    System Settings → Privacy & Security → "Open Anyway", or run:

      xattr -dr com.apple.quarantine "/Applications/GDW Mirror Host.app"

    The Windows receiver is a separate portable .exe, available at
    https://mirror.gdw.mx/#download
  EOS
end
