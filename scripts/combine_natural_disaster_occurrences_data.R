library(tidyverse)
source("scripts/helper_functions.R")

ensure_dir("derived_data")

# Climatological occurrences
long_climatological_occurrences <- read_csv("source_data/natural_disasters/climatological_disasters.csv",
                                           na = c("...", "…", "")) %>%
  select(2:5) %>%
  rename(Country = `Countries or areas`) %>%
  mutate(Country = clean_country_names(Country)) %>%
  rename(`1990-1999` = `Occurrence 1990-1999`) %>%
  rename(`2000-2009` = `Occurrence 2000-2009`) %>%
  rename(`2010-2019` = `Occurrence 2010-2019`) %>%
  pivot_longer(!Country, names_to = "Year range", 
               values_to = "Climatological") %>%
  filter(!is.na(Climatological))

# Geophysical occurrences
long_geophysical_occurrences <- read_csv("source_data/natural_disasters/geophysical_disasters.csv",
                                            na = c("...", "…", "")) %>%
  select(2:5) %>%
  rename(Country = `Countries or areas`) %>%
  mutate(Country = clean_country_names(Country)) %>%
  rename(`1990-1999` = `Occurrence 1990-1999`) %>%
  rename(`2000-2009` = `Occurrence 2000-2009`) %>%
  rename(`2010-2019` = `Occurrence 2010-2019`) %>%
  pivot_longer(!Country, names_to = "Year range", 
               values_to = "Geophysical") %>%
  filter(!is.na(Geophysical))

# Hydrological occurrences
long_hydrological_occurrences <- read_csv("source_data/natural_disasters/hydrological_disasters.csv",
                                         na = c("...", "…", "")) %>%
  select(2:5) %>%
  rename(Country = `Countries or areas`) %>%
  mutate(Country = clean_country_names(Country)) %>%
  rename(`1990-1999` = `Occurrence 1990-1999`) %>%
  rename(`2000-2009` = `Occurrence 2000-2009`) %>%
  rename(`2010-2019` = `Occurrence 2010-2019`) %>%
  pivot_longer(!Country, names_to = "Year range", 
               values_to = "Hydrological") %>%
  filter(!is.na(Hydrological))

# Meteorogical occurrences
long_meteorogical_occurrences <- read_csv("source_data/natural_disasters/meteorological_disasters.csv",
                                          na = c("...", "…", "")) %>%
  select(2:5) %>%
  rename(Country = `Countries or areas`) %>%
  mutate(Country = clean_country_names(Country)) %>%
  rename(`1990-1999` = `Occurrence 1990-1999`) %>%
  rename(`2000-2009` = `Occurrence 2000-2009`) %>%
  rename(`2010-2019` = `Occurrence 2010-2019`) %>%
  pivot_longer(!Country, names_to = "Year range", 
               values_to = "Meteorogical") %>%
  filter(!is.na(Meteorogical))

# Combine hazardous waste data
natural_disaster_occurrences <- full_join(long_climatological_occurrences, long_geophysical_occurrences)
natural_disaster_occurrences <- full_join(natural_disaster_occurrences, long_hydrological_occurrences)
natural_disaster_occurrences <- full_join(natural_disaster_occurrences, long_meteorogical_occurrences)

write_csv(natural_disaster_occurrences, "derived_data/natural_disaster_occurrences.csv")
