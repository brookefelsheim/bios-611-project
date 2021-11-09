library(tidyverse)

if(!dir.exists("derived_data")) {
  dir.create("derived_data")
}

yearly_municipal_recycled <- read_csv("source_data/waste/percentage_of_municipal_waste_collected_which_is_recycled.csv",
                             na = c("...", "")) 

long_yearly_municipal_recycled <- yearly_municipal_recycled %>%
  select(2:26) %>%
  pivot_longer(!Country, names_to = "Year", 
               values_to = "Percent") %>%
  mutate(Year = as.numeric(Year)) %>%
  filter(!is.na(Percent))

write_csv(long_yearly_municipal_recycled, "derived_data/long_yearly_municipal_recycled.csv")
