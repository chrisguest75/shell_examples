class GitActivity < Formula
  desc "Generate a report on git repos and PR branches"
  homepage "https://github.com/chrisguest75/shell_examples"
  url "https://github.com/chrisguest75/shell_examples/releases/download/0.0.1-f43376d/git-activity-release.tar.gz"
  sha256 "1a97b6ac991f8f2547c7807603663373223c7faad79239031af29427a398816b"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "66c940e56f22cd2f5fdb3cfd2e1ddd741400c0739bb91ded95f5ddf5fa3c9902"
  end

  # depends_on "gh"
  depends_on "spark"

  def install
    bin.install "git-activity"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test shell_examples`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    # system "false"

    assert_match "usage: git-activity.sh options", shell_output("#{bin}/git-activity.sh --help")
  end
end
