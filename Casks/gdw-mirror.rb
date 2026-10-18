cask "gdw-mirror" do
  version "0.2.0"

  on_arm do
    sha256 "61a842490e3e40b10709d862de80186523c707c6ab69f30417c812bec0842936"
    url "https://github.com/josecruzchavez/gdw-mirror/releases/download/v#{version}/GDW-Mirror-Host-#{version}-arm64.zip"
  end

  on_intel do
    sha256 "c315039b7aff28ddb0a00137cfe514f0bc85c1073269ffb5d293f8e3a3b0d9ac"
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
