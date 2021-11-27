
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
                       "Eswatini (Kingdom of)")
  countries <- replace(countries, 
                       countries == "Kingdom of Eswatini",
                       "Eswatini (Kingdom of)")
  countries <- replace(countries,
                       countries == "Swaziland",
                       "Eswatini (Kingdom of)")
  countries <- replace(countries, 
                       countries == "Hong Kong; China (SAR)",
                       "China, Hong Kong SAR")
  countries <- replace(countries, 
                       countries == "Republic of Korea",
                       "Korea (Republic of)")
  countries <- replace(countries, 
                       countries == "Korea, Republic of",
                       "Korea (Republic of)")
  countries <- replace(countries, 
                       countries == "Korea, DemocraticPpl's.Republic",
                       "Korea (Republic of)")
  countries <- replace(countries, 
                       countries == "Democratic People's Republic of Korea",
                       "Korea (Republic of)")
  countries <- replace(countries, 
                       countries == "Republic of Moldova",
                       "Moldova (Republic of)")
  countries <- replace(countries, 
                       countries == "Palestine; State of",
                       "Palestine (State of)")
  countries <- replace(countries, 
                       countries == "State of Palestine",
                       "Palestine (State of)")
  countries <- replace(countries, 
                       countries == "United Republic of Tanzania",
                       "Tanzania (United Republic of)")
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