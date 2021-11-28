library(tidyverse)
source("scripts/helper_functions.R")

ensure_dir("derived_data")

happiness_2015 <- read_csv("source_data/happiness/2015.csv") %>%
  mutate(`2015` = `Happiness Score`) %>%
  mutate(Country = clean_country_names(Country)) %>%
  select(c(Country, Region, `2015`))

happiness_2016 <- read_csv("source_data/happiness/2016.csv") %>%
  mutate(`2016` = `Happiness Score`) %>%
  mutate(Country = clean_country_names(Country)) %>%
  select(c(Country, Region, `2016`))

happiness_2017 <- read_csv("source_data/happiness/2017.csv") %>%
  mutate(`2017` = Happiness.Score) %>%
  mutate(Country = clean_country_names(Country)) %>%
  select(c(Country, `2017`))

happiness_2018 <- read_csv("source_data/happiness/2018.csv") %>%
  rename(Country = `Country or region`) %>%
  mutate(`2018` = Score) %>%
  mutate(Country = clean_country_names(Country)) %>%
  select(c(Country, `2018`))

happiness_2019 <- read_csv("source_data/happiness/2019.csv") %>%
  rename(Country = `Country or region`) %>%
  mutate(`2019` = Score) %>%
  mutate(Country = clean_country_names(Country)) %>%
  select(c(Country, `2019`))

yearly_happiness <- full_join(happiness_2015, happiness_2016)
yearly_happiness <- full_join(yearly_happiness, happiness_2017)
yearly_happiness <- full_join(yearly_happiness, happiness_2018)
yearly_happiness <- full_join(yearly_happiness, happiness_2019)

write_csv(yearly_happiness, "derived_data/yearly_happiness.csv")
