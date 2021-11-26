library(tidyverse)
source("scripts/helper_functions.R")

ensure_dir("derived_data")

yearly_renewable_percentage <- read_csv("source_data/energy_and_minerals/renewable_elec_production_percentage.csv",
                                     na = c("...", "")) 

long_yearly_renewable_percentage <- yearly_renewable_percentage %>%
  select(2:30) %>%
  rename(Country = `Country and area`) %>%
  mutate(Country = clean_country_names(Country)) %>%
  filter(!is.na(Country)) %>%
  pivot_longer(!Country, names_to = "Year", 
               values_to = "Percent") %>%
  filter(!is.na(Percent))

write_csv(long_yearly_renewable_percentage, "derived_data/long_yearly_renewable_percentage.csv")