library(tidyverse)

if(!dir.exists("derived_data")) {
	dir.create("derived_data")
}

CO2_emissions <- read_csv("source_data/Air and Climate/CO2_Emissions.csv", 
                skip = 1, na = "...") %>%
  select(-1) %>%
  rename(Country = "...2", "Latest Year Emissions (1000 t)" = "1000 t", 
         "Percent Change Since 1990" = "%", 
         "Latest Year Emissions Per Capita (kg)" = "kg")

long_CO2_emissions <- CO2_emissions %>%
  select(Country:`2018`) %>%
  pivot_longer(!Country, names_to = "Year", 
               values_to = "CO2 Emissions (1000 t)") %>%
  mutate(Year = as.numeric(Year)) %>%
  filter(!is.na(`CO2 Emissions (1000 t)`))

write_csv(long_CO2_emissions, "derived_data/long_CO2_emissions.csv")
