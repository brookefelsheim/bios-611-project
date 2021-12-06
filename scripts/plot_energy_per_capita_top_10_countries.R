library(tidyverse)
source("scripts/helper_functions.R")

ensure_dir("figures")

pdf(NULL)

long_yearly_energy_per_capita <- read_csv("derived_data/long_yearly_energy_per_capita.csv")

highest_10_countries_per_capita <- long_yearly_energy_per_capita %>%
  arrange(desc(`Energy per capita`)) %>% select(Country) %>% 
  distinct() %>% pull(Country) %>% head(10)

supply_plot <- ggplot(long_yearly_energy_per_capita %>% 
                     filter(Country %in% highest_10_countries_per_capita),
                   aes(x = Year, y = `Energy per capita`)) + 
  geom_point(aes(color = Country)) + 
  geom_line(aes(color = Country)) + theme_bw()

long_yearly_renewable_percentage <- read_csv("derived_data/long_yearly_renewable_percentage.csv")

renewable_plot <- ggplot(long_yearly_renewable_percentage %>% 
                           filter(Country %in% highest_10_countries_per_capita),
                         aes(x = Year, y = Percent)) + 
  geom_point(aes(color = Country)) + 
  geom_line(aes(color = Country)) + theme_bw() + ylab("Percent renewable energy (of total energy)")

energy_per_capita_plot <- ggarrange(supply_plot, renewable_plot, labels = c("A", "B"), ncol = 2, nrow = 1,
                    common.legend = TRUE, legend = "right")

ggsave("figures/top_10_energy_per_capita_countries.png", 
       width = 10, height = 4, plot = energy_per_capita_plot, bg = "white")
