library(tidyverse)

if(!dir.exists("derived_data")) {
  dir.create("derived_data")
}

# CH4 emissions
long_CH4_emissions <- read_csv("source_data/Air and Climate/CH4_Emissions.csv",
                               skip = 1, na = "...") %>%
  select(-1) %>%
  rename(Country = "...2") %>%
  select(Country:`2018`) %>%
  pivot_longer(!Country, names_to = "Year", 
               values_to = "CH4") %>%
  mutate(Year = as.numeric(Year)) %>%
  filter(!is.na(CH4))

# CO2 emissions
long_CO2_emissions <- read_csv("source_data/Air and Climate/CO2_Emissions.csv", 
                          skip = 1, na = "...") %>%
  select(-1) %>%
  rename(Country = "...2") %>%
  select(Country:`2018`) %>%
  pivot_longer(!Country, names_to = "Year", 
               values_to = "CO2") %>%
  mutate(Year = as.numeric(Year)) %>%
  filter(!is.na(CO2))

# N2O emissions
long_N2O_emissions <- read_csv("source_data/Air and Climate/N2O_Emissions.csv", 
                               skip = 1, na = "...") %>%
  select(-1) %>%
  rename(Country = "...2") %>%
  select(Country:`2018`) %>%
  pivot_longer(!Country, names_to = "Year", 
               values_to = "N2O") %>%
  mutate(Year = as.numeric(Year)) %>%
  filter(!is.na(N2O))

# NOx emissions
long_NOx_emissions <- read_csv("source_data/Air and Climate/NOx_Emissions.csv", 
                               skip = 1, na = c("...", "", "…")) %>%
  select(-1) %>%
  rename(Country = "...2") %>%
  select(Country:`2018`) %>%
  pivot_longer(!Country, names_to = "Year", 
               values_to = "NOx") %>%
  mutate(Year = as.numeric(Year)) %>%
  filter(!is.na(NOx))

# SO2 emissions
long_SO2_emissions <- read_csv("source_data/Air and Climate/SO2_emissions.csv", 
                               skip = 1, na = c("...", "", "…")) %>%
  select(-1) %>%
  rename(Country = "...2") %>%
  select(Country:`2018`) %>%
  pivot_longer(!Country, names_to = "Year", 
               values_to = "SO2") %>%
  mutate(Year = as.numeric(Year)) %>%
  filter(!is.na(SO2))

# All GHG emissions
long_GHG_emissions <- read_csv("source_data/Air and Climate/GHG_emissions.csv", 
                               skip = 1, na = c("...", "", "…")) %>%
  select(-1) %>%
  rename(Country = "...2") %>%
  select(Country:`2018`) %>%
  pivot_longer(!Country, names_to = "Year", 
               values_to = "All greenhouse gasses") %>%
  mutate(Year = as.numeric(Year)) %>%
  filter(!is.na(`All greenhouse gasses`))

# Combine yearly emissions data
yearly_emissions <- full_join(long_CH4_emissions, long_CO2_emissions)
yearly_emissions <- full_join(yearly_emissions, long_N2O_emissions)
yearly_emissions <- full_join(yearly_emissions, long_NOx_emissions)
yearly_emissions <- full_join(yearly_emissions, long_SO2_emissions)
yearly_emissions <- full_join(yearly_emissions, long_GHG_emissions)

write_csv(yearly_emissions, "derived_data/yearly_emissions.csv")
