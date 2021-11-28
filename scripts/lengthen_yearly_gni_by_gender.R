library(tidyverse)
source("scripts/helper_functions.R")

ensure_dir("derived_data")

male_yearly_gni <- read_excel("source_data/economy/income_by_country.xlsx", 
                     sheet = "Estimated GNI male", na = "..")

long_male_yearly_gni <- male_yearly_gni %>% 
  select(1:13) %>%
  mutate(`1995` = as.numeric(`1995`)) %>%
  pivot_longer(!Country, names_to = "Year", 
               values_to = "GNI") %>%
  mutate(Year = as.numeric(Year)) %>%
  filter(!is.na(GNI)) %>%
  mutate(Gender = "Male")

female_yearly_gni <- read_excel("source_data/economy/income_by_country.xlsx", 
                       sheet = "Estimated GNI female", na = "..")

long_female_yearly_gni <- female_yearly_gni %>% 
  select(1:13) %>%
  mutate(`1995` = as.numeric(`1995`)) %>%
  pivot_longer(!Country, names_to = "Year", 
               values_to = "GNI") %>%
  mutate(Year = as.numeric(Year)) %>%
  filter(!is.na(GNI)) %>%
  mutate(Gender = "Female")

long_yearly_gni_by_gender <- rbind(long_male_yearly_gni, long_female_yearly_gni)

write_csv(long_yearly_gni_by_gender, "derived_data/long_yearly_gni_by_gender.csv")
