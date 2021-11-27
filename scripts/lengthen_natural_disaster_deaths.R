library(tidyverse)
source("scripts/helper_functions.R")

ensure_dir("derived_data")

natural_disaster_deaths <- read_csv("derived_data/natural_disaster_deaths.csv")
long_natural_disaster_deaths <- natural_disaster_deaths %>%
  pivot_longer(cols = -c(Country, `Year range`), names_to = "Type", 
               values_to = "Deaths") %>%
  filter(!is.na(Deaths))

write_csv(long_natural_disaster_deaths, "derived_data/long_natural_disaster_deaths.csv")