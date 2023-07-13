#!/bin/bash
FILE=wikivoyage_en_all_maxi_2023-06
ZFILE=$FILE.zim
URL=$(cat wl.list | fzf --preview "zimdump show --url {} $ZFILE | w3m -T text/html")
FURL=http://localhost:8080/wikivoyage_en_all_maxi_2023-06/$URL
surf $FURL
