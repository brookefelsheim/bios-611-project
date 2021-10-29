library(tidyverse)
library(shiny)

yearly_emissions <- read_csv("derived_data/yearly_emissions.csv")

long_yearly_emissions <- yearly_emissions %>%
  pivot_longer(cols = -c(Country, Year), names_to = "Type", 
               values_to = "Emissions") %>%
  filter(!is.na(Emissions))

ui <- fluidPage(
  selectInput("country", 
              label = "Choose a country to display",
              choices = unique(long_yearly_emissions$Country),
              selected = "United States of America"),
  plotOutput("emissions_plot")
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
}

# Start the Server
shinyApp(ui=ui,server=server,
         options=list(port=8080, host="0.0.0.0"))
