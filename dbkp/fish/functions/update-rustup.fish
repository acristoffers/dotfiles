function update-rustup
	title Updating Rust

	if not type -q rustup
		echo "rustup not installed!"
		exit 1
	end

	rustup update
end
