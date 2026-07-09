class PrivacyKit < Formula
  desc "Local macOS privacy audits — permissions, trackers, tunnels, listeners, MDM"
  homepage "https://github.com/krewdev/privacy-kit"
  url "https://github.com/krewdev/privacy-kit/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "d35fc315973ecf017faea39ef7091d729140d8c8613765885879e65938b38e26"
  license "MIT"
  head "https://github.com/krewdev/privacy-kit.git", branch: "main"

  depends_on :macos

  def install
    libexec.install Dir["*"]
    (bin/"pk").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/bin/pk" ""
    EOS
  end

  test do
    assert_match "pk", shell_output("#{bin}/pk version")
    assert_match "audit", shell_output("#{bin}/pk help")
  end
end
