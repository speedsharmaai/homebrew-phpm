# speedsharmaai/homebrew-phpm

Homebrew tap for [phpm](https://github.com/speedsharmaai/phpm), a
Composer-compatible PHP installer written in Rust.

```sh
brew install speedsharmaai/phpm/phpm
```

or

```sh
brew tap speedsharmaai/phpm
brew install phpm
```

macOS (arm64, x86_64) and Linux (arm64, x86_64). Windows isn't supported
yet.

`Formula/phpm.rb` is the formula cargo-dist generates for each
[phpm release](https://github.com/speedsharmaai/phpm/releases), copied here
unchanged. It installs the prebuilt binary from the release; the checksums
come from the same release.

Issues with phpm itself go to
[speedsharmaai/phpm](https://github.com/speedsharmaai/phpm/issues).

Licensed under MIT or Apache-2.0, like phpm.
