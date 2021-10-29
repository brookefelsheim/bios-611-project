library(tidyverse)

if(!dir.exists("figures")) {
  dir.create("figures")
}

if(!dir.exists("logs")) {
  dir.create("logs")
}

yearly_emissions <- read_csv("derived_data/yearly_emissions.csv")


yearly_emissions_full <- 
  yearly_emissions %>% 
  filter(!is.na(CH4) & !is.na(CO2) & !is.na(N2O) & !is.na(NOx) &
           !is.na(SO2) & !is.na(`All greenhouse gasses`))

con <- file("logs/emissions_pc_summary.txt")
sink(con, append=TRUE)
summary(pc)
close(con)

country_list <- c("United States of America", "Russian Federation", "Japan", 
                  "Germany", "Australia", "France", "Ukraine", "Spain",
                  "United Kingdom of Great Britain and Northern Ireland",
                  "France", "Uzbekistan", "Italy")

pc_data <- cbind(yearly_emissions_full, pc$x) %>% as_tibble() %>% 
  mutate(Country = ifelse(Country %in% country_list, Country, "Other"))

pc_plot <- ggplot(pc_data, aes(PC1,PC2)) + geom_point(aes(color = Country)) +
  ggtitle("Yearly Greenhouse Gas Emissions Data PC Plot")

ggsave("figures/emissions_pc_plot.png", plot = pc_plot)