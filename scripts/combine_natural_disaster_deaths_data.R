library(tidyverse)

if(!dir.exists("derived_data")) {
  dir.create("derived_data")
}

# Climatological deaths
long_climatological_deaths <- read_csv("source_data/natural_disasters/climatological_disasters.csv",
                                            na = c("...", "…", "")) %>%
  select(c(2, 6:8)) %>%
  rename(Country = `Countries or areas`) %>%
  rename(`1990-1999` = `Total deaths 1990-1999`) %>%
  rename(`2000-2009` = `Total deaths 2000-2009`) %>%
  rename(`2010-2019` = `Total deaths 2010-2019`) %>%
  pivot_longer(!Country, names_to = "Year range", 
               values_to = "Climatological") %>%
  filter(!is.na(Climatological))

# Geophysical deaths
long_geophysical_deaths <- read_csv("source_data/natural_disasters/geophysical_disasters.csv",
                                         na = c("...", "…", "")) %>%
  select(c(2, 6:8)) %>%
  rename(Country = `Countries or areas`) %>%
  rename(`1990-1999` = `Total deaths 1990-1999`) %>%
  rename(`2000-2009` = `Total deaths 2000-2009`) %>%
  rename(`2010-2019` = `Total deaths 2010-2019`) %>%
  pivot_longer(!Country, names_to = "Year range", 
               values_to = "Geophysical") %>%
  filter(!is.na(Geophysical))

# Hydrological deaths
long_hydrological_deaths <- read_csv("source_data/natural_disasters/hydrological_disasters.csv",
                                          na = c("...", "…", "")) %>%
  select(c(2, 6:8)) %>%
  rename(Country = `Countries or areas`) %>%
  rename(`1990-1999` = `Total deaths 1990-1999`) %>%
  rename(`2000-2009` = `Total deaths 2000-2009`) %>%
  rename(`2010-2019` = `Total deaths 2010-2019`) %>%
  pivot_longer(!Country, names_to = "Year range", 
               values_to = "Hydrological") %>%
  filter(!is.na(Hydrological))

# Meteorogical deaths
long_meteorogical_deaths <- read_csv("source_data/natural_disasters/meteorological_disasters.csv",
                                          na = c("...", "…", "")) %>%
  select(c(2, 6:8)) %>%
  rename(Country = `Countries or areas`) %>%
  rename(`1990-1999` = `Total deaths 1990-1999`) %>%
  rename(`2000-2009` = `Total deaths 2000-2009`) %>%
  rename(`2010-2019` = `Total deaths 2010-2019`) %>%
  pivot_longer(!Country, names_to = "Year range", 
               values_to = "Meteorogical") %>%
  filter(!is.na(Meteorogical))

# Combine hazardous waste data
natural_disaster_deaths <- full_join(long_climatological_deaths, long_geophysical_deaths)
natural_disaster_deaths <- full_join(natural_disaster_deaths, long_hydrological_deaths)
natural_disaster_deaths <- full_join(natural_disaster_deaths, long_meteorogical_deaths)

write_csv(natural_disaster_deaths, "derived_data/natural_disaster_deaths.csv")
