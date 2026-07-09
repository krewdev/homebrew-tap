class HubstaffWorkShell < Formula
  desc "Task-scoped control for the real Hubstaff desktop timer on macOS"
  homepage "https://github.com/krewdev/hubstaff-work-shell"
  url "https://github.com/krewdev/hubstaff-work-shell/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "28528e7ac55939d117dda4e585643ed719ad1f77917cfd9cb138b683d5f2b0b6"
  license "MIT"
  head "https://github.com/krewdev/hubstaff-work-shell.git", branch: "main"

  depends_on :macos

  def install
    libexec.install Dir["*"]
    wrapper = <<~'SH'
      #!/bin/bash
      exec "LIBEXEC_PLACEHOLDER/bin/hs" "$@"
    SH
    (bin/"hs").write wrapper.gsub("LIBEXEC_PLACEHOLDER", libexec.to_s)
  end

  test do
    assert_match "hs", shell_output("#{bin}/hs version")
    assert_match "start", shell_output("#{bin}/hs help")
  end
end
