library(tidyverse)
source("scripts/helper_functions.R")

ensure_dir("derived_data")

yearly_happiness <- read_csv("derived_data/yearly_happiness.csv")
long_yearly_happiness <- yearly_happiness %>%
  pivot_longer(cols = -c(Country, Region), names_to = "Year", 
               values_to = "Happiness_score") %>%
  filter(!is.na(Happiness_score))

write_csv(long_yearly_happiness, "derived_data/long_yearly_happiness.csv")
