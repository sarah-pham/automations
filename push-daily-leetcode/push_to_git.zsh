#!/bin/zsh

src_file="Solution.java"
git_path="../git/leetcode/"

if [[ $# -gt 1 || ($# -eq 1 && $1 -ne "incomplete") ]]; then
    echo "Invalid arguments"
    exit
fi
incomplete=$#

javac $src_file "ShellHelper.java"
methods_pattern=$(java ShellHelper printSolutionMethods)

problem=$(
    grep -oE "$methods_pattern" "$src_file" |   # Search for methods in file
    head -n 1 |                 # Limit to first
    sed -e 's/[A-Z]/-&/g' |     # Add hyphen before each uppercase char
    tr '[:upper:]' '[:lower:]'  # Convert to lowercase
)

current_date=$(date -u "+%Y-%m-%d")
new_dir=($current_date"_"$problem)
dest_path=$git_path$new_dir

if [ ! -d "$dest_path" ]; then
    mkdir $dest_path
    cp $src_file $dest_path
    git_msg="Add solution to $current_date"
else
    git_msg="Update solution to $current_date"
fi

if [[ incomplete -eq 1 ]]; then
    git_msg="[Incomplete] "$git_msg
fi

git -C $git_path add $new_dir
git -C $git_path commit -m $git_msg
git -C $git_path push