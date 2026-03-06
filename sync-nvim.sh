#!/bin/bash
# Sync nvim/ directory from this repo to ~/.config/nvim

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC="$SCRIPT_DIR/nvim"
DEST="$HOME/.config/nvim"

if [ ! -d "$SRC" ]; then
	echo "Error: Source directory not found: $SRC"
	exit 1
fi

echo "=== Neovim Config Sync ==="
echo ""
echo "  Source:      $SRC"
echo "  Destination: $DEST"
echo ""
echo "WARNING: This will DELETE all contents in $DEST"
echo "         and replace them with the contents of $SRC."
echo ""
read -r -p "Are you sure you want to continue? [y/N] " response
case "$response" in
	[yY][eE][sS]|[yY])
		;;
	*)
		echo "Aborted."
		exit 0
		;;
esac

mkdir -p "$DEST"
rsync -av --delete "$SRC/" "$DEST/"
echo ""
echo "Done. Synced $SRC -> $DEST"
