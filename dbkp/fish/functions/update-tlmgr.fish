function update-tlmgr
	if test (uname -s) != "Darwin"
		return
	end

	title Updating TeX

	if not type -q tlmgr
		brew install mactex
	end

	tlmgr update --self
	tlmgr update --all
end
