#!/usr/bin/env bash

current_dir=${DOT_DIR:-$(pwd)}

do_not_link=(\
  "config"\
  "link.sh"\
  "local"\
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
  local file_name=$(echo "${file_abspath}" | rev | cut -d'/' -f 1 | rev)
  local link_location=${HOME}/.${file_relpath}
  local link_parent_dir=$(echo "${link_location}" | rev | cut -b -${#file_name} --complement | rev)

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
    if [[ $(readlink -f "${link_location}") == "${file_abspath}" ]]
    then
      echo "Link exists and is correct \"${link_location}\" -> \"${file_abspath}\""
      return 0
    else
      # link exists and is wrong - prompt to correct. if no, return 1
      echo "Link exists but points to wrong place: \"${link_location}\" -> \"$(readlink -f "${link_location}")"
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
  for file in $(ls ${1})
  do
    file_abspath="${1}/${file}"
    file_relpath=${file_abspath:${#current_dir}+1}
    echo $file_relpath
    if element_in "${file_relpath}" "${do_not_link[@]}"
    then
      # skip if file, recurse if directory
      if [[ -d ${file_abspath} ]]
      then
        link "${file_abspath}"
      fi
    else
      create_link "${file_abspath}"
    fi
  done
}

link "${current_dir}"

