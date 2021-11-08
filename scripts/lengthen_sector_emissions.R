library(tidyverse)

if(!dir.exists("derived_data")) {
  dir.create("derived_data")
}

sector_emissions <- read_csv("source_data/air_and_climate/ghg_emissions_by_sector.csv",
                             na = "...") 

long_sector_emissions <- sector_emissions %>%
  rename(Energy = `GHG from energy, as percentage to total`) %>%
  rename(`Industrial processes` = `GHG from industrial processes and product use, as percentage to total`) %>%
  rename(Agriculture = `GHG from agriculture, as percentage to total`) %>%
  rename(Waste = `GHG from waste, as percentage to total`) %>%
  select(Country, `Latest Year Available`, Energy, `Industrial processes`,
         Agriculture, Waste) %>%
    pivot_longer(!c(Country, `Latest Year Available`), names_to = "Type", 
                 values_to = "Percent") %>%
    filter(!is.na(Percent))

write_csv(long_sector_emissions, "derived_data/long_sector_emissions.csv")