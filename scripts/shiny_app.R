library(tidyverse)
library(shiny)

# Load in datasets
long_yearly_emissions <- read_csv("derived_data/long_yearly_emissions.csv")
long_sector_emissions <- read_csv("derived_data/long_sector_emissions.csv")
long_yearly_energy_per_capita <- read_csv("derived_data/long_yearly_energy_per_capita.csv")
long_yearly_renewable_percentage <- read_csv("derived_data/long_yearly_renewable_percentage.csv")
long_yearly_forest_area <- read_csv("derived_data/long_yearly_forest_area.csv")
long_yearly_precipitation <- read_csv("derived_data/long_yearly_precipitation.csv")
long_natural_disaster_occurrences <- read_csv("derived_data/long_natural_disaster_occurrences.csv")
long_natural_disaster_deaths <- read_csv("derived_data/long_natural_disaster_deaths.csv")
long_yearly_hazardous_waste <- read_csv("derived_data/long_yearly_hazardous_waste.csv")
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
      p("This shiny app displays enviromental indicator data from the United Nations Statistics Division (UNSD) / United Nations Environment Programme (UNEP) Questionairre on Environment Statistics for 190 countries. Please note that not every country has data available for each type of environmental indicator displayed. If a country is missing data for a particular type of plot, that plot will be blank."),
      width = 3, fluid = FALSE
    ),
    mainPanel(
      h3("Air and Climate"),
      plotOutput("emissions_plot", width = 820),
      plotOutput("sector_plot", width = 720),
      h3("Energy"),
      plotOutput("energy_per_capita_plot", width = 650),
      plotOutput("renewable_percentage_plot", width = 650),
      h3("Forests"),
      plotOutput("forest_area_plot", width = 650),
      h3("Inland Water Resources"),
      plotOutput("precipitation_plot", width = 650),
      h3("Natural Disasters"),
      plotOutput("natural_disaster_occurrences_plot", width = 820),
      plotOutput("natural_disaster_deaths_plot", width = 820),
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
  
  output$energy_per_capita_plot <- renderPlot(
    ggplot(long_yearly_energy_per_capita %>%
             filter(Country == input$country),
           aes(x = Year, y = `Energy per capita`)) +
      geom_point(color="#D39200") + geom_line(color="#D39200") + 
      ylab("Energy Supply per Capita\n(Gigajoules per capita)") + theme_bw() +
      ggtitle(paste0("Energy Supply per Capita by Year\n", input$country)) +
      theme(axis.text = element_text(size = 16),
            axis.title = element_text(size = 17, face="bold"),
            title = element_text(size = 20)))
  
  output$renewable_percentage_plot <- renderPlot(
    ggplot(long_yearly_renewable_percentage %>%
             filter(Country == input$country),
           aes(x = Year, y = Percent)) +
      geom_point(color="#D39200") + geom_line(color="#D39200") + 
      ylab("Renewable Energy\n(% of total energy production)") + theme_bw() +
      ggtitle(paste0("Renewable Energy Production Percentage by Year\n", input$country)) +
      theme(axis.text = element_text(size = 16),
            axis.title = element_text(size = 17, face="bold"),
            title = element_text(size = 20)))
  
  output$forest_area_plot <- renderPlot(
    ggplot(long_yearly_forest_area %>%
             filter(Country == input$country),
           aes(x = Year, y = Area)) +
      geom_point(color="#00BA38") + geom_line(color="#00BA38") + 
      ylab("Total Forest Area\n(1000 ha)") + theme_bw() +
      ggtitle(paste0("Forest Area by Year\n", input$country)) +
      theme(axis.text = element_text(size = 16),
            axis.title = element_text(size = 17, face="bold"),
            title = element_text(size = 20)))
  
  output$precipitation_plot <- renderPlot(
    ggplot(long_yearly_precipitation %>%
             filter(Country == input$country),
           aes(x = Year, y = Amount)) +
      geom_point(color="#00B9E3") + geom_line(color="#00B9E3") + 
      ylab("Amount of Precipitation\n(Million cubic metres)") + theme_bw() +
      ggtitle(paste0("Amount of Precipitation by Year\n", input$country)) +
      theme(axis.text = element_text(size = 16),
            axis.title = element_text(size = 17, face="bold"),
            title = element_text(size = 20)))
  
  output$natural_disaster_occurrences_plot <- renderPlot(
    ggplot(long_natural_disaster_occurrences %>%
             filter(Country == input$country),
           aes(x = `Year range`, fill = Type, y = Occurrences)) + 
      geom_bar(stat = "identity") + 
      ggtitle(paste0("Natural Disaster Occurrences by Year Range\n", input$country)) +
      theme(axis.text = element_text(size = 16),
            axis.title = element_text(size = 17, face="bold"),
            title = element_text(size = 20),
            legend.text = element_text(size = 16)))
  
  output$natural_disaster_deaths_plot <- renderPlot(
    ggplot(long_natural_disaster_deaths %>%
             filter(Country == input$country),
           aes(x = `Year range`, fill = Type, y = Deaths)) + 
      geom_bar(stat = "identity") + 
      ggtitle(paste0("Natural Disaster Deaths by Year Range\n", input$country)) +
      theme(axis.text = element_text(size = 16),
            axis.title = element_text(size = 17, face="bold"),
            title = element_text(size = 20),
            legend.text = element_text(size = 16)))
  
  output$hazardous_waste_plot <- renderPlot(
    ggplot(long_yearly_hazardous_waste %>%
             filter(Country == input$country),
           aes(x = Year, y = Tonnes)) +
      geom_point(aes(color=Category)) + geom_line(aes(color=Category)) + theme_bw() +
      ylab("Amount of Hazardous Waste\n(Tonnes)") +
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
      ylab("Municipal Waste Recycled\n(%)") + theme_bw() +
      ggtitle(paste0("Percentage of Municipal Waste Recycled by Year\n", input$country)) +
      theme(axis.text = element_text(size = 16),
            axis.title = element_text(size = 17, face="bold"),
            title = element_text(size = 20)))
}

# Start the Server
shinyApp(ui=ui,server=server,
         options=list(port=8080, host="0.0.0.0"))
