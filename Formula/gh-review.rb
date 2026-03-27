class GhReview < Formula
  desc "Terminal UI for reviewing GitHub pull requests"
  homepage "https://github.com/Neville-Loh/gh-review"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Neville-Loh/gh-review/releases/download/v0.1.3/gh-review-aarch64-apple-darwin.tar.xz"
      sha256 "eb420aabbd7476c3189c88c4858935973387217071dfa628e29b8fa6c321a711"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Neville-Loh/gh-review/releases/download/v0.1.3/gh-review-x86_64-apple-darwin.tar.xz"
      sha256 "a9dd5bb94d2346654e7282c6a6faa9bab5cef24576d6fdffc32c439efa7e4d15"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Neville-Loh/gh-review/releases/download/v0.1.3/gh-review-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "430e4570e3f6a98773fa1f1a19b9a5f0514351822da1d49839adb3a387c28836"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Neville-Loh/gh-review/releases/download/v0.1.3/gh-review-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "382438de1fe7dabfcb2209da93edc69cbd77d13d0f5e6f9288f56d1d104280a7"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "gh-review"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gh-review"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "gh-review"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gh-review"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
