cask "gdw-mirror" do
  version "0.2.3"

  on_arm do
    sha256 "955858abda0bc8fc0478183153e4509a0616c0d9152bf3b0243cdac438704145"

    url "https://github.com/josecruzchavez/gdw-mirror/releases/download/v#{version}/GDW-Mirror-#{version}-arm64.zip"
  end
  on_intel do
    sha256 "cffeab3134ecbfb96932efb410cfc00e6181446298c4b8ab3162bb235823c96c"

    url "https://github.com/josecruzchavez/gdw-mirror/releases/download/v#{version}/GDW-Mirror-#{version}-x64.zip"
  end

  name "GDW Mirror"
  desc "Share screens over a local network"
  homepage "https://mirror.gdw.mx/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "GDW Mirror.app"

  zap trash: [
    "~/Library/Application Support/com.gdw.mirror.host",
    "~/Library/Application Support/GDW Mirror",
    "~/Library/Application Support/mx.gdw.mirror",
    "~/Library/Caches/com.gdw.mirror.host",
    "~/Library/Caches/GDW Mirror",
    "~/Library/Caches/mx.gdw.mirror",
    "~/Library/Preferences/com.gdw.mirror.host.plist",
    "~/Library/Preferences/mx.gdw.mirror.plist",
    "~/Library/Saved Application State/com.gdw.mirror.host.savedState",
    "~/Library/Saved Application State/mx.gdw.mirror.savedState",
  ]

  caveats <<~EOS
    GDW Mirror runs from the menu bar. Use its menu to share this screen or
    open the remote viewer. The first time you share, macOS will ask for
    Screen Recording permission.

    The macOS app is signed with Developer ID and notarized by Apple, so
    Gatekeeper should allow it to open without manually removing quarantine.
    The Windows x64 app is available at https://mirror.gdw.mx/#download.
  EOS
end
