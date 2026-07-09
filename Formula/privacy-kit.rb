class PrivacyKit < Formula
  desc "Local macOS privacy audits — permissions, trackers, tunnels, listeners, MDM"
  homepage "https://github.com/krewdev/privacy-kit"
  url "https://github.com/krewdev/privacy-kit/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "33bdaff34c52b1e5ed20f0d505554ccf208fc8434f362363d2fe20eb5e796d00"
  license "MIT"
  head "https://github.com/krewdev/privacy-kit.git", branch: "main"

  depends_on :macos

  def install
    libexec.install Dir["*"]
    wrapper = <<~'SH'
      #!/bin/bash
      exec "LIBEXEC_PLACEHOLDER/bin/pk" "$@"
    SH
    (bin/"pk").write wrapper.gsub("LIBEXEC_PLACEHOLDER", libexec.to_s)
  end

  test do
    assert_match "pk", shell_output("#{bin}/pk version")
    assert_match "audit", shell_output("#{bin}/pk help")
  end
end
