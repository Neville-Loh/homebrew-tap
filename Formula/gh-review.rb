class GhReview < Formula
  desc "Terminal UI for reviewing GitHub pull requests"
  homepage "https://github.com/Neville-Loh/gh-review"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Neville-Loh/gh-review/releases/download/v0.1.2/gh-review-aarch64-apple-darwin.tar.xz"
      sha256 "93225f5936a751289c10fa18c0c95c571e6c2b22a660cd9de9cdfa71106a2bc4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Neville-Loh/gh-review/releases/download/v0.1.2/gh-review-x86_64-apple-darwin.tar.xz"
      sha256 "6551e871389a0bd8d2879e0bbb38fee4f69c102c41c2d06306dc3283108c6936"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Neville-Loh/gh-review/releases/download/v0.1.2/gh-review-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e9c2024d5919cde9920b15408c544cec0723495f61025ba168cd8d8d264dde61"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Neville-Loh/gh-review/releases/download/v0.1.2/gh-review-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2366bd5542721cf3b2aa2cc7a2f4bf76da3cd88d922121358394eb8f10eae78a"
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
