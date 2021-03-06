library(tidyverse)
source("scripts/helper_functions.R")

ensure_dir("derived_data")

yearly_energy_per_capita <- read_csv("source_data/energy_and_minerals/energy_supply_per_capita.csv",
                             na = c("...", "")) 

long_yearly_energy_per_capita <- yearly_energy_per_capita %>%
  select(2:30) %>%
  rename(Country = `Country and area`) %>%
  mutate(Country = clean_country_names(Country)) %>%
  filter(!is.na(Country)) %>%
  pivot_longer(!Country, names_to = "Year", 
               values_to = "Energy per capita") %>%
  filter(!is.na(`Energy per capita`))

write_csv(long_yearly_energy_per_capita, "derived_data/long_yearly_energy_per_capita.csv")