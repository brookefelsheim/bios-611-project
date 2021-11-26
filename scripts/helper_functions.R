
ensure_dir <- function(dir) {
  if(!dir.exists(dir)) {
    dir.create(dir)
  }
}

clean_country_names <- function(countries) {
  countries <- gsub("’", "'", countries)
  countries <- sub("Rep\\.", "Republic", countries)
  countries <- sub("Dem\\.", "Democratic", countries)
  countries <- sub("Bolivar\\.", "Bolivarian", countries)
  countries <- sub("Plur\\.", "Plurinational", countries)
  countries <- sub("Fed\\.", "Federated", countries)
  countries <- sub("Special Administrative Region", "SAR", countries)
  countries <- sub("St\\.", "Saint", countries)
  countries <- sub("Is\\.", "Islands", countries)
  countries <- replace(countries, 
                       countries == "Congo (Democratic Republic of the)",
                       "Democratic Republic of the Congo")
  countries <- replace(countries, 
                       countries == "Congo",
                       "Democratic Republic of the Congo")
  countries <- replace(countries, 
                       countries == "CÃ´te d'Ivoire",
                       "Côte d’Ivoire")
  countries <- replace(countries, 
                       countries == "Eswatini",
                       "Kingdom of Eswatini")
  countries <- replace(countries, 
                       countries == "Eswatini (Kingdom of)",
                       "Kingdom of Eswatini")
  countries <- replace(countries,
                       countries == "Swaziland",
                       "Kingdom of Eswatini")
  countries <- replace(countries, 
                       countries == "Hong Kong; China (SAR)",
                       "China, Hong Kong SAR")
  countries <- replace(countries, 
                       countries == "Korea (Republic of)",
                       "Republic of Korea")
  countries <- replace(countries, 
                       countries == "Korea, Republic of",
                       "Republic of Korea")
  countries <- replace(countries, 
                       countries == "Korea, DemocraticPpl's.Republic",
                       "Republic of Korea")
  countries <- replace(countries, 
                       countries == "Democratic People's Republic of Korea",
                       "Republic of Korea")
  countries <- replace(countries, 
                       countries == "Moldova (Republic of)",
                       "Republic Moldova")
  countries <- replace(countries, 
                       countries == "Palestine; State of",
                       "State of Palestine")
  countries <- replace(countries, 
                       countries == "Palestine (State of)",
                       "State of Palestine")
  countries <- replace(countries, 
                       countries == "Tanzania (United Republic of)",
                       "United Republic of Tanzania")
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
                       countries == "United Kingdom",
                       "United Kingdom of Great Britain and Northern Ireland")
  countries <- replace(countries, 
                       countries == "United States",
                       "United States of America")
}