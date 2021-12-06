library(tidyverse)
library(ggpubr)
source("scripts/helper_functions.R")

ensure_dir("figures")

pdf(NULL)

long_yearly_energy <- read_csv("derived_data/long_yearly_energy.csv")

highest_10_countries <- long_yearly_energy %>%
  arrange(desc(Energy)) %>% select(Country) %>% 
  distinct() %>% pull(Country) %>% head(10)

supply_plot <- ggplot(long_yearly_energy %>% 
                        filter(Country %in% highest_10_countries),
                      aes(x = Year, y = Energy)) + 
  geom_point(aes(color = Country)) + 
  geom_line(aes(color = Country)) + theme_bw() +
  ylab("Energy supply\n(Petajoules)")

long_yearly_renewable_percentage <- read_csv("derived_data/long_yearly_renewable_percentage.csv")

renewable_plot <- ggplot(long_yearly_renewable_percentage %>% 
                           filter(Country %in% highest_10_countries),
                         aes(x = Year, y = Percent)) + 
  geom_point(aes(color = Country)) + 
  geom_line(aes(color = Country)) + theme_bw() + 
  ylab("Renewable energy usage\n(% of total supply)")

energy_plot <- ggarrange(supply_plot, renewable_plot, 
                                    labels = c("A", "B"), ncol = 2, nrow = 1,
                                    common.legend = TRUE, legend = "right")

ggsave("figures/top_10_energy_countries.png", 
       width = 10, height = 4, plot = energy_plot, bg = "white")


