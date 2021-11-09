library(tidyverse)
library(shiny)

yearly_emissions <- read_csv("derived_data/yearly_emissions.csv")
long_sector_emissions <- read_csv("derived_data/long_sector_emissions.csv")
long_yearly_forest_area <- read_csv("derived_data/long_yearly_forest_area.csv")

long_yearly_emissions <- yearly_emissions %>%
  pivot_longer(cols = -c(Country, Year), names_to = "Type", 
               values_to = "Emissions") %>%
  filter(!is.na(Emissions))

ui <- fluidPage(
  selectInput("country", 
              label = "Choose a country to display",
              choices = unique(long_yearly_emissions$Country),
              selected = "United States of America"),
  plotOutput("emissions_plot", width = 820),
  plotOutput("sector_plot", width = 720),
  plotOutput("forest_area_plot", width = 600)
)

server <- function(input, output) {
  
  output$emissions_plot <- renderPlot(
    ggplot(long_yearly_emissions %>%
             filter(Country == input$country),
           aes(x = Year, y = Emissions)) +
      geom_point(aes(color=Type)) + geom_line(aes(color=Type)) + theme_bw() +
      ylab("Emissions\n(1000 tonnes of CO2 equivalent)") +
      ggtitle(paste0("Greenhouse Gas Emissions by Year\n", input$country)) +
      theme(axis.text = element_text(size = 16),
            axis.title = element_text(size = 18, face="bold"),
            title = element_text(size = 20),
            legend.text = element_text(size = 16)))
  
  output$sector_plot <- renderPlot(
    ggplot(long_sector_emissions %>%
             filter(Country == input$country),
           aes(x = "", y = Percent, fill = Type)) +
      geom_bar(stat="identity", width=1, color="white") +
      coord_polar("y", start=0) +
      theme_void() +
      geom_text(aes(label = Percent),
                position = position_stack(vjust = 0.5)) +
      ggtitle(paste0("Greenhouse Gas Emissions by Sector (%)\n", input$country)) +
      theme(title = element_text(size = 20),
            legend.text = element_text(size = 16)))
  
  output$forest_area_plot <- renderPlot(
    ggplot(long_yearly_forest_area %>%
             filter(Country == input$country),
           aes(x = Year, y = Area)) +
      geom_point(color="#148242") + geom_line(color="#148242") + 
      ylab("Total Forest Area\n(1000 ha)") + theme_bw() +
      ggtitle(paste0("Forest Area by Year\n", input$country)) +
      theme(axis.text = element_text(size = 16),
            axis.title = element_text(size = 18, face="bold"),
            title = element_text(size = 20)))
}

# Start the Server
shinyApp(ui=ui,server=server,
         options=list(port=8080, host="0.0.0.0"))
