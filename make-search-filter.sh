#!/usr/bin/env bash

# Create filter list metadata
echo "! Title: Ardis Lu's Search filter" >'search-filter.txt'
echo '! Description: Remove low-quality websites and nuisances from Google, Bing, Yahoo, and DuckDuckGo search results.' >>'search-filter.txt'
echo '! Expires: 14 days' >>'search-filter.txt'
echo '! Homepage: https://github.com/ardislu/uBlock-Origin-search-filter' >>'search-filter.txt'
echo '! Licence: https://github.com/ardislu/uBlock-Origin-search-filter/blob/main/LICENSE' >>'search-filter.txt'

# Append all lines from nuisances.txt which do not start with ! or whitespace or is an empty line
grep -Ev '^(!|\s)|^$' ./nuisances.txt | tr -d '\r' >>'search-filter.txt'

# Create search engine filters for all websites on websites.txt
grep -Ev '^(!|\s)|^$' ./websites.txt | tr -d '\r' | while read -r line; do
  echo "google.*##.g:has(a[href*=\"$line\"])" >>'search-filter.txt'    # Google
  echo "bing.*##.b_algo:has(a[href*=\"$line\"])" >>'search-filter.txt' # Bing
  echo "yahoo.*##li:has(a[href*=\"$line\"])" >>'search-filter.txt'     # Yahoo
  echo "duckduckgo.*##[data-domain*=\"$line\"]" >>'search-filter.txt'  # DuckDuckGo
done
