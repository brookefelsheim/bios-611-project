library(tidyverse)
library(readxl)
source("scripts/helper_functions.R")

ensure_dir("derived_data")

gdp <- read_excel("source_data/economy/income_by_country.xlsx", 
                     sheet = "GDP per capita", na = "..")

long_yearly_gdp <- gdp %>% 
  select(1:14) %>%
  mutate(`1990` = as.numeric(`1990`)) %>%
  mutate(Country = clean_country_names(Country)) %>%
  pivot_longer(!Country, names_to = "Year", 
               values_to = "GDP_per_capita") %>%
  mutate(Year = as.numeric(Year)) %>%
  filter(!is.na(GDP_per_capita))

write_csv(long_yearly_gdp, "derived_data/long_yearly_gdp.csv")
