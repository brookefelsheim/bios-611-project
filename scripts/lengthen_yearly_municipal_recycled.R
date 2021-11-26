library(tidyverse)
source("scripts/helper_functions.R")

ensure_dir("derived_data")

yearly_municipal_recycled <- read_csv("source_data/waste/percentage_of_municipal_waste_collected_which_is_recycled.csv",
                             na = c("...", "")) 

long_yearly_municipal_recycled <- yearly_municipal_recycled %>%
  select(2:26) %>%
  mutate(Country = clean_country_names(Country)) %>%
  pivot_longer(!Country, names_to = "Year", 
               values_to = "Percent") %>%
  mutate(Year = as.numeric(Year)) %>%
  filter(!is.na(Percent))

write_csv(long_yearly_municipal_recycled, "derived_data/long_yearly_municipal_recycled.csv")
