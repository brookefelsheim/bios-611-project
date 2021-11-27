library(tidyverse)
source("scripts/helper_functions.R")

ensure_dir("derived_data")

natural_disaster_occurrences <- read_csv("derived_data/natural_disaster_occurrences.csv")

long_natural_disaster_occurrences <- natural_disaster_occurrences %>%
  pivot_longer(cols = -c(Country, `Year range`), names_to = "Type", 
               values_to = "Occurrences") %>%
  filter(!is.na(Occurrences))

write_csv(long_natural_disaster_occurrences, "derived_data/long_natural_disaster_occurrences.csv")