#!/bin/zsh

TARGET_DIR="~/attachments/"
BIN_PATH="$HOME/.Trash"

# todo: check if this is faster
# combined_files=$(find . -type f -name "*.md" -exec cat {} +)

used=()
unused=()
IFS=$'\n' attachments=($(find "${TARGET_DIR}" -type f))
for file in ${attachments[@]}; do
    if grep -qr --exclude-dir=".obsidian" ${file#"${TARGET_DIR}"} .; then
        used+=("$file")
    else
        unused+=("$file")
    fi
done

echo "🔔 You have ${#unused} orphaned files which have no backlinks."

if [[ ${#unused} == 0 ]]
then
    echo "Nothing to delete."
    exit
fi

echo "Deleting the following ${#unused} unused files..."

bin_items="unused_obsidian_attachments_$(date +'%d-%m-%Y_%I.%M%p')" # Move the discarded files to a directory
mkdir "${bin_items}"

for file in $unused; do
    echo "${file#"${TARGET_DIR}"}"
    mv "${file}" "${bin_items}"
done

mv "${bin_items}/" "${BIN_PATH}/"

echo "\nMoved ${#unused} items to system trash. Completed."
echo "Deleted items are at '${BIN_PATH}/${bin_items}'"