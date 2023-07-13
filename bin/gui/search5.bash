#!/usr/bin/env bash
FILES=$(ls *.zim)

# search() 
# {
#     for zf in $FILES; do echo "$(zimsearch $zf $1)"; done
# }
# search $1
fzf --ansi --disabled --query "" \
    --bind "change:reload:sleep 0.1; ls *.zim | xargs zimsearch {q} || true" \
    # --delimiter : \
    # --preview "zimdump show --url {} $ZFILE | w3m -T text/html" \
    # --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
    # --bind 'enter:become(vim {1} +{2})'
