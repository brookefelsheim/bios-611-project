library(tidyverse)

if(!dir.exists("figures")) {
  dir.create("figures")
}

if(!dir.exists("logs")) {
  dir.create("logs")
}

yearly_emissions <- read_csv("derived_data/yearly_emissions.csv")

long_yearly_emissions <- yearly_emissions %>%
  pivot_longer(cols = -c(Country, Year), names_to = "Type", 
               values_to = "Emissions") %>%
  filter(!is.na(Emissions))

highest_10_countries <- yearly_emissions %>% 
  arrange(desc(`All greenhouse gasses`)) %>% select(Country) %>% distinct() %>% pull(Country) %>% head(10)

write.table(highest_10_countries, "logs/top_10_countries_emissions.txt",
            col.names = F, row.names = F, quote = F)


ghg_plot <- ggplot(long_yearly_emissions %>% 
         filter(Type == "All greenhouse gasses") %>%
         filter(Country %in% highest_10_countries),
       aes(x = Year, y = Emissions)) + 
  geom_point(aes(color = Country)) + 
  geom_line(aes(color = Country)) + theme_bw() + 
  ggtitle("Greenhouse gas emission trends for top 10 emitting countries")

ggsave("figures/ghg_emissions_trends_top_10_plot.png", 
       width = 10, height = 6, plot = ghg_plot)
