library(tidyverse)

if(!dir.exists("derived_data")) {
  dir.create("derived_data")
}

forest_area <- read_csv("source_data/forests/forest_area.csv",
                             na = c("...", "…")) 

long_yearly_forest_area <- forest_area %>%
  rename(Country = `Country and Area`) %>%
  rename(`1990` = `Forest Area, 1990 (1000 ha)`) %>%
  rename(`2000` = `Forest Area, 2000 (1000 ha)`) %>%
  rename(`2010` = `Forest Area, 2010 (1000 ha)`) %>%
  rename(`2015` = `Forest Area, 2015 (1000 ha)`) %>%
  rename(`2020` = `Forest Area, 2020 (1000 ha)`) %>%
  select(Country, `1990`, `2000`, `2010`, `2015`, `2020`) %>%
  pivot_longer(!Country, names_to = "Year", 
               values_to = "Area") %>%
  filter(!is.na(Area))

write_csv(long_yearly_forest_area, "derived_data/long_yearly_forest_area.csv")