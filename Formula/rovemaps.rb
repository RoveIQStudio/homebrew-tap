class Rovemaps < Formula
  desc "Drive RoveMaps Studio from a terminal: every Studio MCP tool as a command, plus file upload and download."
  homepage "https://github.com/RoveIQStudio/rovemaps-cli"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/RoveIQStudio/rovemaps-cli/releases/download/cli/v0.2.1/rovemaps-aarch64-apple-darwin.tar.xz"
      sha256 "906d4a240b33610a99b4cc3a27fc381dbd125a7aface33f5939063ca6a9986e6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RoveIQStudio/rovemaps-cli/releases/download/cli/v0.2.1/rovemaps-x86_64-apple-darwin.tar.xz"
      sha256 "5bc855bf4b2ff144a35346dedbe68f1c5e18411ac4e79a2d5e28b21f47c3ec07"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/RoveIQStudio/rovemaps-cli/releases/download/cli/v0.2.1/rovemaps-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "405a3c1148b694f4c6a969560d201dfb4b9350bd000ebd7c82affadf7b79818b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RoveIQStudio/rovemaps-cli/releases/download/cli/v0.2.1/rovemaps-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4648787fb1ec0ee6a12a9cb4f7c72bdb742013a0469367b45069def652dcce06"
    end
  end

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
      bin.install "rovemaps"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "rovemaps"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "rovemaps"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "rovemaps"
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
