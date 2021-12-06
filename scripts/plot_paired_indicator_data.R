library(tidyverse)
library(readxl)
library(GGally)
source("scripts/helper_functions.R")

ensure_dir("figures")

pdf(NULL)

all_predictive_data <- read_csv("derived_data/all_predictive_data.csv")

plot <- ggpairs(all_predictive_data[,-1:-2], 
                columnLabels = c("GHG emissions\n(kg per capita)", 
                                 "Energy consumption\n (GJ per capita)",
                                 "Renewable energy\n(% of total)",
                                 "Agricultural area\n(%)", 
                                 "Forest area\n(%)",
                                 "Protected area\n(%)", 
                                 "Economic activity\n(GDP per capita)", 
                                 "Happiness\n(Survey score)"))

ggsave("figures/paired_indicators.png", 
       width = 10, height = 10, plot = plot)
