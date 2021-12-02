library(tidyverse)
library(readxl)
library(ggpubr)
source("scripts/helper_functions.R")

ensure_dir("figures")
ensure_dir("outputs")

pdf(NULL)

all_predictive_data <- read_csv("derived_data/all_predictive_data.csv")

pc <- prcomp(scale(all_predictive_data[,3:8]))

saveRDS(summary(pc), "outputs/environmental_indicator_pc_summary.rds")

pc_data <- cbind(all_predictive_data[,1:2], pc$x) %>% as_tibble()

pc_plot <- ggplot(pc_data, aes(PC1,PC2)) + geom_point(aes(color = Region)) + 
  geom_text(data = subset(pc_data, PC1 > 2 & PC2 < 2),
            aes(PC1, PC2, label = Country),
            hjust = 0, nudge_x = 0.2) + xlim(c(-2, 10)) + 
  xlab(paste0("PC1 (", round(summary(pc)$importance[2,1],4)*100, "%)")) + 
  ylab(paste0("PC2 (", round(summary(pc)$importance[2,2],4)*100, "%)"))

box_plot <-  ggplot(pc_data, aes(x = Region, y = PC1, fill = Region)) + 
  geom_boxplot() + coord_flip()  +
  ylim(c(-2, 10))

figure <- ggarrange(pc_plot, box_plot, heights = c(2, 0.7),
                    ncol = 1, nrow = 2, align = "v", 
                    common.legend = TRUE, legend = "right")

ggsave("figures/environmental_indicator_pc_plot.png", 
       width = 10, height = 8, plot = pc_plot)
