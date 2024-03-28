function update-rustup
  if type -q rustup
    title Updating Rust
    rm -rf $RUSTUP_HOME
    rustup default stable
    rustup component add rust-analyzer
    cargo install cargo-edit
    nix-shell -p stdenv cargo rustc openssl pkg-config --command "cargo install cargo-edit"
  end
end
