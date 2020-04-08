#!/usr/bin/env bash
# afaneh92 @ xda-developers
# Generate a specific picklist from inside your repo:
# git log --pretty=format:"%h # %s" > picklist

LIST_FILE="${1}"

if [ "${LIST_FILE}" = "" ] ; then
  echo "Pleas give path to commit list file!"
  echo "Usage: ./cherry-pick.sh picklist"
  exit 1
fi

echo "Cherry-picking all commits from file ${LIST_FILE} ..."

COUNT=1
IFS=$'\n'
for commit in $(tac "${LIST_FILE}") ; do
  hash=$(echo ${commit} | cut -d$' ' -f 1)
  echo -n "cherry picking ${hash} ... "
  git cherry-pick "${hash}"

  if [ $? -eq 0 ] ; then
    echo "done."
  else
    echo "There are conflicts to resolve!"
    read -p "Press [ENTER] key if you have resolved the conflicts and to continue ..."
  fi

  COUNT=$((COUNT+1))
done

echo "Maybe you want to rebase: git rebase -i HEAD~${COUNT}"
