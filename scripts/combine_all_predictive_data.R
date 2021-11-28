library(tidyverse)
library(readxl)
source("scripts/helper_functions.R")

ensure_dir("derived_data")

##### Air and climate data

# GHG emissions per capita, latest year (kg of CO2 equivalent)
ghg <- read_csv("source_data/air_and_climate/ghg_emissions.csv",
                skip = 1, na = c("...", "", "…")) %>%
  rename(Country = 2) %>%
  mutate(Country = clean_country_names(Country)) %>%
  rename(GHG_per_capita_emissions = 35) %>%
  select(Country, GHG_per_capita_emissions) %>%
  filter(!is.na(Country)) %>%
  filter(!is.na(GHG_per_capita_emissions)) 

##### Biodiversity data

# Terrestrial and marine protected areas, latest year (% of total territorial area)
protected_areas <- read_csv("source_data/biodiversity/terrestrial_marine_protected_areas.csv",
                            na = c("...", "", "…")) %>%
  rename(Country = `Country and area`) %>%
  mutate(Country = clean_country_names(Country)) %>%
  rename(Protected_area_percent = 4) %>%
  select(Country, Protected_area_percent) %>%
  filter(!is.na(Country)) %>%
  filter(!is.na(Protected_area_percent))

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
  filter(!is.na(Country)) %>%
  filter(!is.na(Energy_per_capita)) %>%
  filter(!is.na(Renewable_energy_percent))
  

##### Forest data

# Forest area as a proportion of total land area, 2020 (%)
forest_area <- read_csv("source_data/forests/forest_area.csv",
                        na = c("...", "", "…")) %>%
  rename(Country = `Country and Area`) %>%
  mutate(Country = clean_country_names(Country)) %>%
  rename(Forest_area_percent = 9) %>%
  select(Country, Forest_area_percent) %>%
  filter(!is.na(Country)) %>%
  filter(!is.na(Forest_area_percent))

##### Land and agriculture data

# Agricultural land area as a proportion of total land area, 2013 (%)
agricultural_area <- read_csv("source_data/land_and_agriculture/agricultural_land.csv",
                              na = c("...", "", "…")) %>%
  rename(Agricultural_area_percent = 4) %>%
  select(Country, Agricultural_area_percent) %>%
  mutate(Country = clean_country_names(Country)) %>%
  filter(!is.na(Country)) %>%
  filter(!is.na(Agricultural_area_percent))

##### GDP

# GDP per capita, 2018
gdp <- read_excel("source_data/economy/income_by_country.xlsx", 
             sheet = "GDP per capita", na = "..") %>%
  rename(GDP_per_capita = `2018`) %>%
  select(Country, GDP_per_capita) %>%
  mutate(Country = clean_country_names(Country)) %>%
  filter(!is.na(Country)) %>%
  filter(!is.na(GDP_per_capita)) 

##### Happiness

# Happiness score, 2018
happiness <- read_csv("derived_data/yearly_happiness.csv") %>%
  rename(Happiness_score = `2018`) %>%
  select(Country, Region, Happiness_score) %>%
  mutate(Country = clean_country_names(Country)) %>%
  filter(!is.na(Country)) %>%
  filter(!is.na(Happiness_score)) 
  
##### Combine all predictive data

all_predictive_data <- inner_join(ghg, energy, by = "Country")
all_predictive_data <- inner_join(all_predictive_data, agricultural_area, by = "Country")
all_predictive_data <- inner_join(all_predictive_data, forest_area, by = "Country")
all_predictive_data <- inner_join(all_predictive_data, protected_areas, by = "Country")
all_predictive_data <- inner_join(all_predictive_data, gdp, by = "Country")
all_predictive_data <- inner_join(all_predictive_data, happiness, by = "Country")

all_predictive_data <- all_predictive_data %>%
  relocate(Country, Region)

write_csv(all_predictive_data, "derived_data/all_predictive_data.csv")