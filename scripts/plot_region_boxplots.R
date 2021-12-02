library(tidyverse)
library(readxl)
library(ggpubr)
source("scripts/helper_functions.R")

ensure_dir("figures")

pdf(NULL)

all_predictive_data <- read_csv("derived_data/all_predictive_data.csv")

plot1 <- ggplot(all_predictive_data, 
                aes(x = Region, y = Happiness_score, fill = Region)) + 
  geom_boxplot() + ylab("Happiness score") + 
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())

plot2 <- ggplot(all_predictive_data, 
                aes(x = Region, y = GDP_per_capita, fill = Region)) + 
  geom_boxplot() + ylab("GDP per capita") + 
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())

figure <- ggarrange(plot1, plot2, labels = c("A", "B"), ncol = 2, nrow = 1,
                    common.legend = TRUE, legend = "right")

ggsave("figures/region_boxplots.png", 
       width = 10, height = 4, plot = figure, bg = "white")
