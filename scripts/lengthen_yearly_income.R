library(tidyverse)
source("scripts/helper_functions.R")

ensure_dir("derived_data")

income <- read_excel("source_data/income/income_by_country.xlsx", 
                     sheet = "GDP per capita", na = "..")

long_yearly_income <- income %>% 
  select(1:14) %>%
  mutate(`1990` = as.numeric(`1990`)) %>%
  pivot_longer(!Country, names_to = "Year", 
               values_to = "GDP_per_capita") %>%
  mutate(Year = as.numeric(Year)) %>%
  filter(!is.na(GDP_per_capita))

write_csv(long_yearly_income, "derived_data/long_yearly_income.csv")
