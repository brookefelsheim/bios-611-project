library(tidyverse)
source("scripts/helper_functions.R")

ensure_dir("derived_data")

yearly_emissions <- read_csv("derived_data/yearly_emissions.csv")
long_yearly_emissions <- yearly_emissions %>%
  pivot_longer(cols = -c(Country, Year), names_to = "Type", 
               values_to = "Emissions") %>%
  filter(!is.na(Emissions))

write_csv(long_yearly_emissions, "derived_data/long_yearly_emissions.csv")