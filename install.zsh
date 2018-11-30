#!/usr/bin/env zsh

DIR="${0:A:h}"
echo "DIR=$DIR"

function create_link {
  source="$1"
  target="$2"

  printf "linking %s to %s..." $source $target

  if [ -e $target ]; then
    printf "moving already existing %s to %s.bak..." $target $target
    mv "$target" "${target}.bak"
  fi

  ln -s $source $target
  printf "DONE!\n"
}

setopt EXTENDED_GLOB
for rcfile in "$DIR"/runcoms/^README.md(.N); do
  create_link "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

create_link "${DIR}" "${ZDOTDIR:-$HOME}/.zprezto"

chsh -s /bin/zsh

