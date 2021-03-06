function laser() {
  (( $+commands[pdf2laser] )) || { echo "pdf2laser not found" && return 1 }
  [[ $# -eq 2  ]] || { echo "usage: laser <preset> <file>" && return 2 }
  local preset=$1
  local file=$2
  test -f $file || { echo "file '$file' not found" && return 3 }
  [[ $file =~ .svg$ ]] && convert $file ${file/\.svg/\.pdf}
  file=${file/\.svg/\.pdf}
  [[ $file =~ .pdf$ ]] || { echo "file '$file' not pdf" && return 4 }
  set -A cardboard --raster-power 80 --raster-speed 100 --frequency 20 --vector-power 100 --vector-speed 4

  test -v $preset || { echo "preset '$preset' not found" && return 5 }
  local args=${${(P)preset}}

  pd2flaser $args $file
}
