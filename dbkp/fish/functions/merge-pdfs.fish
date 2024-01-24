# Defined in /var/folders/25/by_gngxd5sv134wdn951h_2r0000gn/T//fish.cFVnfH/merge-pdfs.fish @ line 2
function merge-pdfs
  if test (count $argv) -lt 3
    echo Usage:
    echo merge-pdfs output-file input1 input2 [input3 ... inputN]
    return
  end
  set output $argv[1]
  set inputs $argv[2..-1]
  gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite "-sOutputFile=$output" $inputs
end
