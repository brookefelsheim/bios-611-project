library(tidyverse)
source("scripts/helper_functions.R")

ensure_dir("derived_data")

yearly_energy <- read_csv("source_data/energy_and_minerals/energy_supply.csv",
                                     na = c("...", "")) 

long_yearly_energy <- yearly_energy %>%
  select(2:30) %>%
  rename(Country = `Country and area`) %>%
  mutate(Country = clean_country_names(Country)) %>%
  filter(!is.na(Country)) %>%
  pivot_longer(!Country, names_to = "Year", 
               values_to = "Energy") %>%
  filter(!is.na(Energy))

write_csv(long_yearly_energy, "derived_data/long_yearly_energy.csv")
