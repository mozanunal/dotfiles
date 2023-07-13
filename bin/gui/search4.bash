#!/usr/bin/env bash
FILE="$1"
ZS_PREFIX="zimsearch $FILE"
ZS_POSTFIX="sed 'N;s/\n/ /'"

ARTICLE=$(fzf --ansi --disabled --query "" \
    --bind "start:reload:$ZS_PREFIX {q} | $ZS_POSTFIX" \
    --bind "change:reload:sleep 0.1; $ZS_PREFIX {q} | $ZS_POSTFIX || true" \
    | awk '{print $2}')
echo $ARTICLE
zimdump show --idx $ARTICLE $FILE | w3m -T text/html
# --delimiter : \
    # --preview "zimdump show --url {} $ZFILE | w3m -T text/html" \
    # --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
    # --bind 'enter:become(vim {1} +{2})'
