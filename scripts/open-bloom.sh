#!/usr/bin/env bash
# Open a directory in Bloom, reusing the front window when possible.
# Usage: open-bloom.sh [PATH]  — default: current directory

set -euo pipefail

DIR="${1:-.}"
DIR="$(cd "$DIR" && pwd)"
FILE_URI="$(python3 -c 'from pathlib import Path; import sys; print(Path(sys.argv[1]).as_uri())' "$DIR")"

osascript - "$DIR" "$FILE_URI" <<'APPLESCRIPT'
on run argv
	set targetPath to item 1 of argv
	set fileUri to item 2 of argv
	tell application "Bloom"
		activate
		try
			set rootURL of front window to targetPath
		on error
			open URL fileUri
		end try
	end tell
end run
APPLESCRIPT

echo "Bloom: $DIR"
