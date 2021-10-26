library(tidyverse)
library(shiny)

long_CO2_emissions <- read_csv("derived_data/long_CO2_emissions.csv")

ui <- fluidPage(
  selectInput("country", "Select a country:",
              unique(long_CO2_emissions$Country)),
  plotOutput("emissions_plot")
)

server <- function(input, output) {
  output$emissions_plot <- renderPlot(ggplot(long_CO2_emissions %>%
                                               filter(Country == input$country),
                                             aes(x = Year, 
                                                 y = `CO2 Emissions (1000 t)`)) +
                                        geom_point() + geom_line() + theme_bw() +
                                        ggtitle(paste(input$country, 
                                                      "CO2 Emissions by Year")) +
                                        theme(axis.text=element_text(size=16),
                                              axis.title=element_text(size=18,face="bold"),
                                              title=element_text(size=20)))
}

# Start the Server
shinyApp(ui=ui,server=server,
         options=list(port=8080, host="0.0.0.0"))
