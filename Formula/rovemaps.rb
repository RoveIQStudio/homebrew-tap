class Rovemaps < Formula
  desc "Drive RoveMaps Studio from a terminal: every Studio MCP tool as a command, plus file upload and download."
  homepage "https://github.com/RoveIQStudio/rovemaps-cli"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/RoveIQStudio/rovemaps-cli/releases/download/cli/v0.5.0/rovemaps-aarch64-apple-darwin.tar.xz"
      sha256 "5cf938df95816a19707a8f67ff2f73a7a684852bacadc7f5389a3aac0f571f4f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RoveIQStudio/rovemaps-cli/releases/download/cli/v0.5.0/rovemaps-x86_64-apple-darwin.tar.xz"
      sha256 "24f682d4ae9294f268c0bd7efffb3855ded76bb41c640551e8853906cfb970e3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/RoveIQStudio/rovemaps-cli/releases/download/cli/v0.5.0/rovemaps-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "19017bb2cc829ddc3f51e41f30118e11fdbe8b37420fcbd66d1186a8347c591e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RoveIQStudio/rovemaps-cli/releases/download/cli/v0.5.0/rovemaps-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a56b213108f7850a20cd778ec04122c5b3e74856bcd465731bbd610125e66a23"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

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
