
ensure_dir <- function(dir) {
  if(!dir.exists(dir)) {
    dir.create(dir)
  }
}

clean_country_names <- function(countries) {
  countries <- gsub("’", "'", countries)
  countries <- gsub("&", "and", countries)
  countries <- gsub("é", "e", countries)
  countries <- gsub("ç", "c", countries)
  countries <- gsub("ô", "o", countries)
  countries <- sub("Rep\\.", "Republic", countries)
  countries <- sub("Dem\\.", "Democratic", countries)
  countries <- sub("Bolivar\\.", "Bolivarian", countries)
  countries <- sub("Plur\\.", "Plurinational", countries)
  countries <- sub("Fed\\.", "Federated", countries)
  countries <- sub("Special Administrative Region", "SAR", countries)
  countries <- sub("St\\.", "Saint", countries)
  countries <- sub("Is\\.", "Islands", countries)
  countries <- sub(" region", " Region", countries)
  countries <- replace(countries, 
                       countries == "Democratic Republic of the Congo",
                       "Congo (Democratic Republic of the)")
  countries <- replace(countries, 
                       countries == "Congo (Kinshasa)",
                       "Congo (Democratic Republic of the)")
  countries <- replace(countries, 
                       countries == "Congo",
                       "Congo (Republic of the)")
  countries <- replace(countries, 
                       countries == "Congo (Brazzaville)",
                       "Congo (Republic of the)")
  countries <- replace(countries, 
                       countries == "CÃ´te d'Ivoire",
                       "Ivory Coast")
  countries <- replace(countries, 
                       countries == "Cote d’Ivoire",
                       "Ivory Coast")
  countries <- replace(countries, 
                       countries == "Czechia",
                       "Czech Republic")
  countries <- replace(countries, 
                       countries == "Eswatini (Kingdom of)",
                       "Eswatini")
  countries <- replace(countries, 
                       countries == "Kingdom of Eswatini",
                       "Eswatini")
  countries <- replace(countries,
                       countries == "Swaziland",
                       "Eswatini")
  countries <- replace(countries, 
                       countries == "Hong Kong; China (SAR)",
                       "Hong Kong")
  countries <- replace(countries, 
                       countries == "China, Hong Kong SAR",
                       "Hong Kong")
  countries <- replace(countries, 
                       countries == "Hong Kong S.A.R., China",
                       "Hong Kong")
  countries <- replace(countries, 
                       countries == "China, Macao SAR",
                       "Macao")
  countries <- replace(countries, 
                       countries == "Republic of Korea",
                       "South Korea")
  countries <- replace(countries, 
                       countries == "Korea, Republic of",
                       "South Korea")
  countries <- replace(countries, 
                       countries == "Korea, DemocraticPpl's.Republic",
                       "South Korea")
  countries <- replace(countries, 
                       countries == "Democratic People's Republic of Korea",
                       "South Korea")
  countries <- replace(countries, 
                       countries == "Korea (Republic of)",
                       "South Korea")
  countries <- replace(countries, 
                       countries == "Republic of Moldova",
                       "Moldova")
  countries <- replace(countries, 
                       countries == "Moldova (Republic of)",
                       "Moldova")
  countries <- replace(countries, 
                       countries == "Palestine; State of",
                       "Palestine")
  countries <- replace(countries, 
                       countries == "State of Palestine",
                       "Palestine")
  countries <- replace(countries, 
                       countries == "Palestine (State of)",
                       "Palestine")
  countries <- replace(countries, 
                       countries == "Palestinian Territories",
                       "Palestine")
  countries <- replace(countries, 
                       countries == "United Republic of Tanzania",
                       "Tanzania")
  countries <- replace(countries, 
                       countries == "Tanzania (United Republic of)",
                       "Tanzania")
  countries <- replace(countries, 
                       countries == "Saint Kitts-Nevis",
                       "Saint Kitts and Nevis")
  countries <- replace(countries, 
                       countries == "Saint Helena and Depend.",
                       "Saint Helena")
  countries <- replace(countries, 
                       countries == "Saint Pierre-Miquelon",
                       "Saint Pierre and Miquelon")
  countries <- replace(countries, 
                       countries == "Saint Vincent-Grenadines",
                       "Saint Vincent and the Grenadines")
  countries <- replace(countries, 
                       countries == "United Kingdom of Great Britain and Northern Ireland",
                       "United Kingdom")
  countries <- replace(countries, 
                       countries == "United States",
                       "United States of America")
  countries <- replace(countries, 
                       countries == "Macedonia",
                       "North Macedonia")
  countries <- replace(countries,
                       countries == "Venezuela (Bolivarian Republic)",
                       "Venezuela")
  countries <- replace(countries,
                       countries == "Venezuela (Bolivarian Republic of)",
                       "Venezuela")
  countries <- replace(countries,
                       countries == "Bolivia (Plurinational State of)",
                       "Bolivia")
  countries <- replace(countries,
                       countries == "Russian Federation",
                       "Russia")
  countries <- replace(countries,
                       countries == "North Cyprus",
                       "Northern Cyprus")
  countries <- replace(countries,
                       countries == "Iran (Islamic Republic of)",
                       "Iran")
  countries <- replace(countries,
                       countries == "Syrian Arab Republic",
                       "Syria")
  countries <- replace(countries,
                       countries == "Lao People's Democratic Republic",
                       "Laos")
}