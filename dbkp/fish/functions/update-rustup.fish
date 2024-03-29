function update-rustup
  if type -q rustup
    title Updating Rust
    rm -rf $RUSTUP_HOME
    rustup default stable
    rustup component add rust-analyzer
  end
end
