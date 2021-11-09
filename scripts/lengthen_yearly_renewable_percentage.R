library(tidyverse)

if(!dir.exists("derived_data")) {
  dir.create("derived_data")
}

yearly_renewable_percentage <- read_csv("source_data/energy_and_minerals/renewable_elec_production_percentage.csv",
                                     na = c("...", "")) 

long_yearly_renewable_percentage <- yearly_renewable_percentage %>%
  select(2:30) %>%
  rename(Country = `Country and area`) %>%
  filter(!is.na(Country)) %>%
  pivot_longer(!Country, names_to = "Year", 
               values_to = "Percent") %>%
  filter(!is.na(Percent))

write_csv(long_yearly_renewable_percentage, "derived_data/long_yearly_renewable_percentage.csv")