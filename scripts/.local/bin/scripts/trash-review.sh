#!/usr/bin/env bash

set -euo pipefail


TRASH_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/Trash/files"

# Choose previewer
if command -v bat >/dev/null 2>&1; then
    preview_cmd=(bat --paging=always --style=plain)
else
    preview_cmd=(less --RAW-CONTROL-CHARS --quit-if-one-screen --color=auto)
fi

# include hidden files
shopt -s dotglob nullglob

if [ ! -d "$TRASH_DIR" ]; then
    echo "Trash directory not found: $TRASH_DIR"
    exit 1
fi

for f in "$TRASH_DIR"/*; do
    [ -e "$f" ] || continue
    echo "============================================================"
    echo "File: $f"
    echo "------------------------------------------------------------"

    if [ -f "$f" ]; then
        "${preview_cmd[@]}" "$f"
    elif [ -d "$f" ]; then
        echo "[Directory contents]"
        ls -lah --color=always "$f" | "${preview_cmd[@]}"
    else
        echo "[Special file: $(file --brief "$f")]"
    fi

    while true; do
        read -rp "Action? (d=delete permanently, s=save to ~, q=skip) " action
        case "$action" in
            d)
                rm -rf -- "$f"
                echo "Deleted."
                break
                ;;
            s)
                mv -n -- "$f" "$HOME/"
                echo "Saved to ~"
                break
                ;;
            ""|*)
                echo "Skipped."
                break
                ;;
        esac
    done
done
