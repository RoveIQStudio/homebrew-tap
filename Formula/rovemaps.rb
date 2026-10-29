class Rovemaps < Formula
  desc "Drive RoveMaps Studio from a terminal: every Studio MCP tool as a command, plus file upload and download."
  homepage "https://github.com/RoveIQStudio/rovemaps-cli"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/RoveIQStudio/rovemaps-cli/releases/download/cli/v0.3.0/rovemaps-aarch64-apple-darwin.tar.xz"
      sha256 "a08373f4c4248a51823a75dd70cc8000fd205aa77d58767afbc582547b660b64"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RoveIQStudio/rovemaps-cli/releases/download/cli/v0.3.0/rovemaps-x86_64-apple-darwin.tar.xz"
      sha256 "e8d9e0b786d94816c6e498f028cdcc1050d4ddd9cfc422af57b3c3e9e54d3223"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/RoveIQStudio/rovemaps-cli/releases/download/cli/v0.3.0/rovemaps-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2ff65cd8ec33344f4ff5fc231a34e2930c162c364b4651ec14b3292c8a3749dd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RoveIQStudio/rovemaps-cli/releases/download/cli/v0.3.0/rovemaps-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a48bec20afe7f46f761197e8b828dd33b73727964f06b62cba5374f67e0b2c97"
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
