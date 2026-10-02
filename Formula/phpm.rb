class Phpm < Formula
  desc "An extremely fast, Composer-compatible PHP installer"
  homepage "https://speedsharmaai.github.io/phpm/"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/speedsharmaai/phpm/releases/download/v0.1.1/phpm-aarch64-apple-darwin.tar.xz"
      sha256 "2e87ce302130de959a9af83dea305c16789023da2cfe959472d039ff7d33fd01"
    end
    if Hardware::CPU.intel?
      url "https://github.com/speedsharmaai/phpm/releases/download/v0.1.1/phpm-x86_64-apple-darwin.tar.xz"
      sha256 "0ac67db52327fa29131037a18fa7a1deefee31ad3df5d54303bf38c63588179e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/speedsharmaai/phpm/releases/download/v0.1.1/phpm-aarch64-unknown-linux-musl.tar.xz"
      sha256 "dd3757c7655c8d2bb1d3c2e30e3936ada628c2945524e6a24fd26d19541632f5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/speedsharmaai/phpm/releases/download/v0.1.1/phpm-x86_64-unknown-linux-musl.tar.xz"
      sha256 "c530ba6cd92cc486a69ccf874cb4d1156c9228707fa364d1b3739ae8c2214797"
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
