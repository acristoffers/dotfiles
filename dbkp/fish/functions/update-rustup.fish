function update-rustup
  if type -q rustup
    title Updating Rust
    rm -rf $RUSTUP_HOME $XDG_DATA_HOME/cargo
    rustup default stable
    rustup component add rust-analyzer
  end
end
