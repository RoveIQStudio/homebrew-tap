class Rovemaps < Formula
  desc "Drive RoveMaps Studio from a terminal: every Studio MCP tool as a command, plus file upload and download."
  homepage "https://github.com/RoveIQStudio/rovemaps-cli"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/RoveIQStudio/rovemaps-cli/releases/download/cli/v0.4.0/rovemaps-aarch64-apple-darwin.tar.xz"
      sha256 "8c5577f8893778f959f19c249a3a727868b6bc5f949844809730b5e1253c2b2f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RoveIQStudio/rovemaps-cli/releases/download/cli/v0.4.0/rovemaps-x86_64-apple-darwin.tar.xz"
      sha256 "6641f49e02121b13b694aa93308047dbda86df94d82b35676ea6abc15674ec5c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/RoveIQStudio/rovemaps-cli/releases/download/cli/v0.4.0/rovemaps-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4ac57fd82e271350a0de5241e237b9b6bf8106591c0b2f2601c96e9360e83e5d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RoveIQStudio/rovemaps-cli/releases/download/cli/v0.4.0/rovemaps-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "596530fb9d4edf14bd06735d928bba6721e774dedc1590a3f079ce1dbc7b6ec7"
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
