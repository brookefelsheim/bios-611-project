library(tidyverse)
source("scripts/helper_functions.R")

ensure_dir("derived_data")

yearly_hazardous_waste <- read_csv("derived_data/yearly_hazardous_waste.csv")

long_yearly_hazardous_waste <- yearly_hazardous_waste %>%
  pivot_longer(cols = -c(Country, Year), names_to = "Category",
               values_to = "Tonnes") %>%
  filter(!is.na(Tonnes))

write_csv(long_yearly_hazardous_waste, "derived_data/long_yearly_hazardous_waste.csv")