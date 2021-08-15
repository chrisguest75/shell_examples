class GitActivity < Formula
  desc "Git activity report on branches"
  homepage ""
  url "https://github.com/chrisguest75/shell_examples/releases/download/0.0.1-865a1fd/git-activity-release.tar.gz"
  sha256 "3269ef7af68ab0f6570dc12f9579bc36f9217b9f76c44ee0a4315a1e03d97baf"
  license "MIT"

  #bottle do
  #  sha256 cellar: :any_skip_relocation, all: "66c940e56f22cd2f5fdb3cfd2e1ddd741400c0739bb91ded95f5ddf5fa3c9902"
  #end

  depends_on "spark" 
  depends_on "gh" 

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
    #system "false"
  end
end
