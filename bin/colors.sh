for i in {0..255} ; do
  printf "\x1b[38;5;${i}mcolour${i}\n"
  #printf "\x1b[38;5;${i}mHELLO"
done
