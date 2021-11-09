library(tidyverse)

if(!dir.exists("derived_data")) {
  dir.create("derived_data")
}

yearly_precipitation <- read_csv("source_data/inland_water_resources/precipitation.csv",
                                     na = c("...", "")) 

long_yearly_precipitation <- yearly_precipitation %>%
  select(2:30) %>%
  filter(!is.na(Country)) %>%
  pivot_longer(!Country, names_to = "Year", 
               values_to = "Amount") %>%
  filter(!is.na(Amount))

write_csv(long_yearly_precipitation, "derived_data/long_yearly_precipitation.csv")