library(tidyverse)
source("scripts/helper_functions.R")

ensure_dir("derived_data")

##### Air and climate data

# CH4 emissions per capita, latest year (kg)
ch4 <- read_csv("source_data/air_and_climate/ch4_emissions.csv",
                skip = 1, na = c("...", "", "…")) %>%
  rename(Country = 2) %>%
  mutate(Country = clean_country_names(Country)) %>%
  rename(CH4_per_capita_emissions = kg) %>%
  select(Country, CH4_per_capita_emissions) %>%
  filter(!is.na(Country))
  
# CO2 emissions per capita, latest year (kg)
co2 <- read_csv("source_data/air_and_climate/co2_emissions.csv",
                skip = 1, na = c("...", "", "…")) %>%
  rename(Country = 2) %>%
  mutate(Country = clean_country_names(Country)) %>%
  rename(CO2_per_capita_emissions = kg) %>%
  select(Country, CO2_per_capita_emissions) %>%
  filter(!is.na(Country))

# N2O emissions per capita, latest year (kg)
n2o <- read_csv("source_data/air_and_climate/n2o_emissions.csv",
                skip = 1, na = c("...", "", "…")) %>%
  rename(Country = 2) %>%
  mutate(Country = clean_country_names(Country)) %>%
  rename(N2O_per_capita_emissions = kg) %>%
  select(Country, N2O_per_capita_emissions) %>%
  filter(!is.na(Country))

# NOx emissions per capita, latest year (kg)
nox <- read_csv("source_data/air_and_climate/nox_emissions.csv",
                skip = 1, na = c("...", "", "…")) %>%
  rename(Country = 2) %>%
  mutate(Country = clean_country_names(Country)) %>%
  rename(NOx_per_capita_emissions = kg) %>%
  select(Country, NOx_per_capita_emissions) %>%
  filter(!is.na(Country))

# SO2 emissions per capita, latest year (1000 t)
so2 <- read_csv("source_data/air_and_climate/so2_emissions.csv",
                skip = 1, na = c("...", "", "…")) %>%
  rename(Country = 2) %>%
  mutate(Country = clean_country_names(Country)) %>%
  rename(SO2_per_capita_emissions = 35) %>%
  select(Country, SO2_per_capita_emissions) %>%
  filter(!is.na(Country))

# GHG emissions per capita, latest year (kg of CO2 equivalent)
ghg <- read_csv("source_data/air_and_climate/ghg_emissions.csv",
                skip = 1, na = c("...", "", "…")) %>%
  rename(Country = 2) %>%
  mutate(Country = clean_country_names(Country)) %>%
  rename(GHG_per_capita_emissions = 35) %>%
  select(Country, GHG_per_capita_emissions) %>%
  filter(!is.na(Country))

# GHG emissions by sector, latest year (percent of total)
sector_emissions <- read_csv("source_data/air_and_climate/ghg_emissions_by_sector.csv",
                             na = c("...", "", "…")) %>%
  mutate(Country = clean_country_names(Country)) %>%
  rename(Energy_percent_emissions = `GHG from energy, as percentage to total`) %>%
  rename(Industrial_percent = `GHG from industrial processes and product use, as percentage to total`) %>%
  rename(Agriculture_percent_emissions = `GHG from agriculture, as percentage to total`) %>%
  rename(Waste_percent_emissions = `GHG from waste, as percentage to total`) %>%
  select(Country, Energy_percent_emissions, Industrial_percent_emissions,
         Agriculture_percent_emissions, Waste_percent_emissions) %>%
  filter(!is.na(Country))
  
##### Biodiversity data

# Terrestrial and marine protected areas, latest year (% of total territorial area)
protected_areas <- read_csv("source_data/biodiversity/terrestrial_marine_protected_areas.csv",
                            na = c("...", "", "…")) %>%
  rename(Country = `Country and area`) %>%
  mutate(Country = clean_country_names(Country)) %>%
  rename(Protected_area_percent = 4) %>%
  select(Country, Protected_area_percent) %>%
  filter(!is.na(Country))

##### Energy data

# Energy supply per capita, latest year (gigajoules) and contribution of
# renewables to electricity production, latest year (%)
energy <- read_csv("source_data/energy_and_minerals/energy_indicators.csv",
                   na = c("...", "", "…")) %>%
  rename(Country = `Country and area`) %>%
  mutate(Country = clean_country_names(Country)) %>%
  rename(Energy_per_capita = 4) %>%
  rename(Renewable_energy_percent = 5) %>%
  select(Country, Energy_per_capita, Renewable_energy_percent) %>%
  filter(!is.na(Country))

##### Forest data

# Forest area as a proportion of total land area, 2020 (%)
forest_area <- read_csv("source_data/forests/forest_area.csv",
                        na = c("...", "", "…")) %>%
  rename(Country = `Country and Area`) %>%
  mutate(Country = clean_country_names(Country)) %>%
  rename(Forest_area_percent = 9) %>%
  select(Country, Forest_area_percent) %>%
  filter(!is.na(Country))

##### Land and agriculture data

# Agricultural land area as a proportion of total land area, 2013 (%)
agricultural_area <- read_csv("source_data/land_and_agriculture/agricultural_land.csv",
                              na = c("...", "", "…")) %>%
  rename(Agricultural_area_percent = 4) %>%
  select(Country, Agricultural_area_percent) %>%
  mutate(Country = clean_country_names(Country)) %>%
  filter(!is.na(Country))

##### Waste

# Municipal waste collected per capita served, latest year (kg)
municipal_collection <- read_csv("source_data/waste/municipal_waste_collection_(latest_year).csv",
                                 na = c("...", "", "…")) %>%
  rename(Waste_collected_per_capita = 10) %>%
  select(Country, Waste_collected_per_capita) %>%
  mutate(Country = clean_country_names(Country)) %>%
  filter(!is.na(Country))

# Municipal waste treatment per capita served, latest year (%)
municipal_treatment <- read_csv("source_data/waste/municipal_waste_treatment_(latest_year).csv",
                                na = c("...", "", "…")) %>%
  mutate(Country = clean_country_names(Country)) %>%
  rename(Waste_landfilled_percent = 6) %>%
  rename(Waste_incinerated_percent = 8) %>%
  rename(Waste_recycled_percent = 10) %>%
  rename(Waste_composted_percent = 12) %>%
  select(Country, Waste_landfilled_percent, Waste_incinerated_percent,
         Waste_recycled_percent, Waste_composted_percent) %>%
  filter(!is.na(Country))

##### Combine all data

full_latest_year_data <- full_join(ch4, co2)
full_latest_year_data <- full_join(full_latest_year_data, n2o)
full_latest_year_data <- full_join(full_latest_year_data, nox)
full_latest_year_data <- full_join(full_latest_year_data, so2)
full_latest_year_data <- full_join(full_latest_year_data, ghg)
full_latest_year_data <- full_join(full_latest_year_data, sector_emissions)
full_latest_year_data <- full_join(full_latest_year_data, protected_areas)
full_latest_year_data <- full_join(full_latest_year_data, energy)
full_latest_year_data <- full_join(full_latest_year_data, forest_area)
full_latest_year_data <- full_join(full_latest_year_data, agricultural_area)
full_latest_year_data <- full_join(full_latest_year_data, municipal_collection)
full_latest_year_data <- full_join(full_latest_year_data, municipal_treatment)

write_csv(full_latest_year_data, "derived_data/full_latest_year_data.csv")

inner_latest_year_data <- inner_join(forest_area, agricultural_area)
inner_latest_year_data <- inner_join(inner_latest_year_data, energy)
inner_latest_year_data <- inner_join(inner_latest_year_data, protected_areas)
inner_latest_year_data <- inner_join(inner_latest_year_data, ghg)
inner_latest_year_data <- inner_join(inner_latest_year_data, sector_emissions)

write_csv(full_latest_year_data, "derived_data/full_latest_year_data.csv")