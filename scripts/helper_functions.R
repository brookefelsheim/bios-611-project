
ensure_dir <- function(dir) {
  if(!dir.exists(dir)) {
    dir.create(dir)
  }
}

plot_ROC <- function(perf1, perf2, a1, a2, set1, set2, main) {
  png(paste0(main, ".png"), width = 1.5, height = 1.5, units = "in", res = 350)
  par(mai = c(0.24, 0.24, 0.05, 0.05), cex.axis = 0.3)
  plot(perf1, col = "#00BFC4", lwd = 1.2, xlab = "", ylab = "", box.lwd = 0.8,
       xaxis.xaxt = "n", yaxis.yaxt = "n")
  plot(perf2, col = "#F8766D", lwd = 1.2, add = T)
  abline(a=0, b=1, lwd = 0.8)
  axis(1, tck=(-0.02), lwd = 0.8)
  axis(2, tck=(-0.02), lwd = 0.8)
  mtext(side = 1, text = seq(0, 1, by = 0.2), at = seq(0, 1, by=0.2), 
        cex = 0.35, line = (-0.3))
  mtext(side = 2, text = seq(0, 1, by = 0.2), at = seq(0, 1, by=0.2), 
        cex = 0.35, line = 0.1)
  mtext(side = 2, text = "True positive rate", at = 0.5, cex = 0.4, line = 0.6)
  mtext(side = 1, text = "False positive rate", at = 0.5, cex = 0.4, line = 0.2)
  legend("bottomright", legend = c(paste0(set1, " (AUC = ", a1, ")"), 
                                   paste0(set2, " (AUC = ", a2, ")")), 
         lty = c(1,1),lwd = c(1,1) ,
         col = c("#00BFC4", "#F8766D"), cex = 0.35, bty = "n")
  dev.off()
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
                       countries == "Congo (Democratic Republic of the)",
                       "Democratic Republic of the Congo")
  countries <- replace(countries, 
                       countries == "Congo (Kinshasa)",
                       "Democratic Republic of the Congo")
  countries <- replace(countries, 
                       countries == "Congo",
                       "Republic of the Congo")
  countries <- replace(countries, 
                       countries == "Congo (Republic of the)",
                       "Republic of the Congo")
  countries <- replace(countries, 
                       countries == "Congo (Brazzaville)",
                       "Republic of the Congo")
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
                       countries == "Korea (Republic of)",
                       "South Korea")
  countries <- replace(countries, 
                       countries == "Korea, DemocraticPpl's.Republic",
                       "North Korea")
  countries <- replace(countries, 
                       countries == "Democratic People's Republic of Korea",
                       "North Korea")
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
  countries <- replace(countries,
                       countries == "Micronesia (Federated States of)",
                       "Federated States of Micronesia")
}