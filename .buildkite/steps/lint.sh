#!/bin/bash
set -euo pipefail

echo "--- Linting shellscripts with shellcheck"
grep -rl '^#!/.*sh' . | while read -r file ; do
  [[ $file =~ \.git ]] && continue
  [[ $file =~ init\.d ]] && continue
  [[ $file =~ vendor ]] && continue
  [[ $file =~ plugins ]] && continue
  [[ $file =~ node_modules ]] && continue

  echo "Processing $file"
  docker run --rm -v "$PWD:/mnt" koalaman/shellcheck "$file"
  echo -e "Ok.\n"
done

echo "--- Validating cloudformation templates"
make validate