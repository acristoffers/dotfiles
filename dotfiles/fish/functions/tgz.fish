# Defined in /var/folders/25/by_gngxd5sv134wdn951h_2r0000gn/T//fish.KJxamD/tgz.fish @ line 2
function tgz
	set f $argv[1]
	tar -c (basename $f) | gzip -9 > (basename $f).tgz
end
