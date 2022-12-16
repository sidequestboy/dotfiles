#!/usr/bin/env bash

current_dir=$(pwd)

platform=$(uname)

# files to not link, folders to recurse into instead of linking
do_not_link=(\
  "config"\
  "link.sh"\
  "local"\
  "xmonad"\
)

macos_files=(\
  "local/lib/tmux"\
  "nixpkgs"\
  "tmux.conf"\
)

element_in ()
{
  local e match="$1"
  shift
  for e
  do
    [[ "$e" == "$match" ]] && return 0
  done
  return 1
}

create_link()
{
  local file_abspath="${1}"
  local file_relpath=${file_abspath:${#current_dir}+1}
  local file_name=$(basename "${file_abspath}")
  local link_location=${HOME}/.${file_relpath}
  local link_parent_dir=$(dirname "${link_location}")

  # check if parent directory exists,
  #   if not, prompt to create it y/n
  if [[ ! -d "${link_parent_dir}" ]]
  then
    # prompt to create it - if no, return. else continue
    echo "Directory ${link_parent_dir} needs to be created, y/n?"
    read ans
    if [[ ${ans} == "y" ]]
    then
      mkdir -p "${link_parent_dir}"
    else
      echo "Okay nvm, skipping."
      return 1
    fi
  fi

  # check if a real file or folder is there, don't touch it.
  if [[ -e "${link_location}" && ! -L "${link_location}" ]]
  then
    # a real file seems to be there, return.
    echo "A real file or folder exists at ${link_location}. Skipping."
    return 1
  fi
  # check if symlink exists
  if [[ -L "${link_location}" ]]
  then
    if [[ $(readlink "${link_location}") == "${file_abspath}" ]]
    then
      echo "Link exists and is correct \"${link_location}\" -> \"${file_abspath}\""
      return 0
    else
      # link exists and is wrong - prompt to correct. if no, return 1
      echo "Link exists but points to wrong place: \"${link_location}\" -> \"$(readlink "${link_location}")\""
      echo "Fix it? y/n"
      read ans
      if [[ ${ans} == "y" ]]
      then
        rm "${link_location}"
      else
        return 1
      fi
    fi
  fi
    
  # now make the link if we answered yes to all the above checks.
  echo "making link."
  ln -s "${file_abspath}" "${link_location}"
}

link()
{
  local file_abspath="${1}"
  local file_relpath=${file_abspath:${#current_dir}+1}
  local file
  if element_in "${file_relpath}" "${do_not_link[@]}"
  then
    # skip if file, recurse if directory
    if [[ -d ${file_abspath} ]]
    then
      for file in $(ls ${file_abspath})
      do
        link "${file}"
      done
    fi
  else
    create_link "${file_abspath}"
  fi
}

if [[ ${platform} == "Darwin" ]]
then
  for file in "${macos_files[@]}"
  do
    link "${current_dir}/${file}"
  done
else
  for file in $(ls ${1})
  do
    link "${current_dir}"
  done
fi
