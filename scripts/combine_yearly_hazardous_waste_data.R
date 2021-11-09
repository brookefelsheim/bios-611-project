library(tidyverse)

if(!dir.exists("derived_data")) {
  dir.create("derived_data")
}

# Hazardous waste generated
long_hazardous_waste_generated <- read_csv("source_data/waste/hazardous_waste_generated.csv",
                               na = c("...", "…", "")) %>%
  select(2:26) %>%
  pivot_longer(!Country, names_to = "Year", 
               values_to = "Generated") %>%
  mutate(Year = as.numeric(Year)) %>%
  filter(!is.na(Generated))

# Hazardous waste incinerated
long_hazardous_waste_incinerated <- read_csv("source_data/waste/hazardous_waste_incinerated.csv",
                                           na = c("...", "…", "")) %>%
  select(2:26) %>%
  pivot_longer(!Country, names_to = "Year", 
               values_to = "Incinerated") %>%
  mutate(Year = as.numeric(Year)) %>%
  filter(!is.na(Incinerated))

# Hazardous waste landfilled
long_hazardous_waste_landfilled <- read_csv("source_data/waste/hazardous_waste_landfilled.csv",
                                           na = c("...", "…", "")) %>%
  select(2:26) %>%
  pivot_longer(!Country, names_to = "Year", 
               values_to = "Landfilled") %>%
  mutate(Year = as.numeric(Year)) %>%
  filter(!is.na(Landfilled))

# Hazardous waste recycled
long_hazardous_waste_recycled <- read_csv("source_data/waste/hazardous_waste_recycled.csv",
                                            na = c("...", "…", "")) %>%
  select(2:26) %>%
  pivot_longer(!Country, names_to = "Year", 
               values_to = "Recycled") %>%
  mutate(Year = as.numeric(Year)) %>%
  filter(!is.na(Recycled))

# Hazardous waste treated or disposed
long_hazardous_waste_treated_or_disposed <- read_csv("source_data/waste/hazardous_waste_treated_or_disposed.csv",
                                          na = c("...", "…", "")) %>%
  select(2:26) %>%
  pivot_longer(!Country, names_to = "Year", 
               values_to = "Treated or disposed") %>%
  mutate(Year = as.numeric(Year)) %>%
  filter(!is.na(`Treated or disposed`))

# Combine hazardous waste data
yearly_hazardous_waste <- full_join(long_hazardous_waste_generated, long_hazardous_waste_incinerated)
yearly_hazardous_waste <- full_join(yearly_hazardous_waste, long_hazardous_waste_landfilled)
yearly_hazardous_waste <- full_join(yearly_hazardous_waste, long_hazardous_waste_recycled)
yearly_hazardous_waste <- full_join(yearly_hazardous_waste, long_hazardous_waste_treated_or_disposed)

write_csv(yearly_hazardous_waste, "derived_data/yearly_hazardous_waste.csv")
