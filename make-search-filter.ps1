# Create filter list metadata
$metadata = @"
! Title: Search filter
! Description: Remove low-quality websites and nuisances from Google, Bing, Yahoo, and DuckDuckGo search results.
! Expires: 14 days
! Homepage: https://github.com/ardislu/uBlock-Origin-search-filter
! Licence: https://github.com/ardislu/uBlock-Origin-search-filter/blob/main/LICENSE
"@
New-Item .\search-filter.txt -ItemType File -Value $metadata -Force

# Append all lines from nuisances.txt which do not start with ! or whitespace or is an empty line
Get-Content .\nuisances.txt | Where-Object { $_ -notmatch '^(!|\s)|^$' } | Add-Content .\search-filter.txt

# Create search engine filters for all websites on websites.txt
Get-Content .\websites.txt | Where-Object { $_ -notmatch '^(!|\s)|^$' } | ForEach-Object {
  "google.*##.g:has(a[href*=""$_""])" | Add-Content .\search-filter.txt     # Google
  "bing.*##.b_algo:has(a[href*=""$_""])" | Add-Content .\search-filter.txt  # Bing
  "yahoo.*##li:has(a[href*=""$_""])" | Add-Content .\search-filter.txt      # Yahoo
  "duckduckgo.*##[data-domain*=""$_""]" | Add-Content .\search-filter.txt   # DuckDuckGo
}
