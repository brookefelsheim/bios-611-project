library(tidyverse)
library(shiny)

# Load in datasets
yearly_emissions <- read_csv("derived_data/yearly_emissions.csv")
long_yearly_emissions <- yearly_emissions %>%
  pivot_longer(cols = -c(Country, Year), names_to = "Type", 
               values_to = "Emissions") %>%
  filter(!is.na(Emissions))

long_sector_emissions <- read_csv("derived_data/long_sector_emissions.csv")

long_yearly_forest_area <- read_csv("derived_data/long_yearly_forest_area.csv")

yearly_hazardous_waste <- read_csv("derived_data/yearly_hazardous_waste.csv")
long_yearly_hazardous_waste <- yearly_hazardous_waste %>%
  pivot_longer(cols = -c(Country, Year), names_to = "Category",
               values_to = "Tonnes") %>%
  filter(!is.na(Tonnes))

long_yearly_municipal_recycled <- read_csv("derived_data/long_yearly_municipal_recycled.csv")

# User interface
ui <- fluidPage(
  tags$head(
    tags$style(HTML(
      "h2 {
        font-weight: bold;
      }
      h3 {
        font-weight: bold;
        text-decoration: underline;
      }"))
  ),
  titlePanel("Environmental Indicator Data by Country"),
  sidebarLayout(
    sidebarPanel(
      selectInput("country", 
                  label = "Choose a country to display",
                  choices = unique(long_yearly_emissions$Country),
                  selected = "Sweden"),
      p("This shiny app displays enviromental indicator data from the United Nations Statistics Division (UNSD) / United Nations Environment Programme (UNEP) Questionairre on Environment Statistics for 192 countries. Please note that not every country has data available for each type of environmental indicator displayed. If a country is missing data for a particular type of plot, that plot will be blank."),
      width = 3, fluid = FALSE
    ),
    mainPanel(
      h3("Air and Climate"),
      plotOutput("emissions_plot", width = 820),
      plotOutput("sector_plot", width = 720),
      h3("Forests"),
      plotOutput("forest_area_plot", width = 650),
      h3("Waste"),
      plotOutput("hazardous_waste_plot", width = 820),
      plotOutput("municipal_recycled_plot", width = 650)
    )
  )
)

# Server
server <- function(input, output) {
  
  output$emissions_plot <- renderPlot(
    ggplot(long_yearly_emissions %>%
             filter(Country == input$country),
           aes(x = Year, y = Emissions)) +
      geom_point(aes(color=Type)) + geom_line(aes(color=Type)) + theme_bw() +
      ylab("Emissions\n(1000 tonnes of CO2 equivalent)") +
      ggtitle(paste0("Greenhouse Gas Emissions by Year\n", input$country)) +
      theme(axis.text = element_text(size = 16),
            axis.title = element_text(size = 17, face="bold"),
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
            axis.title = element_text(size = 17, face="bold"),
            title = element_text(size = 20)))
  
  output$hazardous_waste_plot <- renderPlot(
    ggplot(long_yearly_hazardous_waste %>%
             filter(Country == input$country),
           aes(x = Year, y = Tonnes)) +
      geom_point(aes(color=Category)) + geom_line(aes(color=Category)) + theme_bw() +
      ylab("Tonnes") +
      ggtitle(paste0("Hazardous Waste Category by Year\n", input$country)) +
      theme(axis.text = element_text(size = 16),
            axis.title = element_text(size = 17, face="bold"),
            title = element_text(size = 20),
            legend.text = element_text(size = 16)))
  
  output$municipal_recycled_plot <- renderPlot(
    ggplot(long_yearly_municipal_recycled %>%
             filter(Country == input$country),
           aes(x = Year, y = Percent)) +
      geom_point(color="#00B9E3") + geom_line(color="#00B9E3") + 
      ylab("Municipal Waste Recycled (%)") + theme_bw() +
      ggtitle(paste0("Percentage of Municipal Waste Recycled by Year\n", input$country)) +
      theme(axis.text = element_text(size = 16),
            axis.title = element_text(size = 17, face="bold"),
            title = element_text(size = 20)))
}

# Start the Server
shinyApp(ui=ui,server=server,
         options=list(port=8080, host="0.0.0.0"))
