function update-rustup
  if type -q rustup
    title Updating Rust
    rm -rf $RUSTUP_HOME
    rustup default stable
    rustup component add rust-analyzer
    nix-shell -p stdenv cargo rustc openssl pkg-config --command "cargo install cargo-edit --force"
  end
end
