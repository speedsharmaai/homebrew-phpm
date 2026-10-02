class Phpm < Formula
  desc "An extremely fast, Composer-compatible PHP installer"
  homepage "https://speedsharmaai.github.io/phpm/"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/speedsharmaai/phpm/releases/download/v0.1.0/phpm-aarch64-apple-darwin.tar.xz"
      sha256 "6e493d3f7ad22933b462d25094a851c65adecf4e2d2dde5751ad78fe70742a06"
    end
    if Hardware::CPU.intel?
      url "https://github.com/speedsharmaai/phpm/releases/download/v0.1.0/phpm-x86_64-apple-darwin.tar.xz"
      sha256 "030ad651496a572160e02351cb33ba4d53ee9eaada2ad64d24e2e88ccf42e163"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/speedsharmaai/phpm/releases/download/v0.1.0/phpm-aarch64-unknown-linux-musl.tar.xz"
      sha256 "c4678ed8e98955a09bc39331fde37c56243a3477c58cd2ee16bca8a7fc343cd3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/speedsharmaai/phpm/releases/download/v0.1.0/phpm-x86_64-unknown-linux-musl.tar.xz"
      sha256 "c524ee15b88e7c3caecfb6bc5f3bf4ed61b4ae736832d484ccb8e1badb1cb2cf"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
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
      bin.install "phpm"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "phpm"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "phpm"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "phpm"
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
