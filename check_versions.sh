#!/bin/bash

taxids=$1

echo "Checking for existing PhosphoSite data for $taxids"

exit_code=1

regulatory_site_version=$(checkversion --remote 'http://www.phosphosite.org/downloads/Regulatory_sites.gz' --header='Last-Modified' --print-remote | { read remote ; date -j -f "%a, %d %b %Y" "$remote" +"%Y-%m-%d"; })

for taxid in ${taxids//,/ }; do
	echo "Checking existence of PhosphoSite data for $taxid"
	testversion_skip_exit "regulatory-$taxid.json" --static "$regulatory_site_version"
	retcode=$?
	if [ $retcode -ne 0 ]; then
		echo "Existing PhosphoSite json for $taxid"
	else
		echo "No existing PhosphoSite json for $taxid"
		exit_code=0
	fi
done

if [ $exit_code -eq 0 ]; then
	true
else
	echo "PhosphoSite regulatory files are up to date"
	false
fi