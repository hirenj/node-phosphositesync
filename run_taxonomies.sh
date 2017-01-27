#!/bin/bash

taxids=$1

if [ ! -e dist ]; then
	mkdir dist;
fi

for taxid in ${taxids//,/ }; do
	runrecipe --input sources --output json --env version="$TARGETVERSION" --env git="$GIT_STATUS" --env timestamp="$(date -u +%FT%TZ)" --env taxid="$taxid"
	mv json/sources_regulatory.json dist/regulatory-$taxid.json
done