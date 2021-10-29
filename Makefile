.PHONY: clean
clean:
	rm -rf derived_data/

.PHONY: all
all: derived_data/long_CO2_emissions.csv

.PHONY: shiny_app
shiny_app: derived_data/long_CO2_emissions.csv shiny_app.R
	Rscript shiny_app.R ${PORT}

derived_data/long_CO2_emissions.csv: source_data/Air\ and\ Climate/CO2_emissions.csv lengthen_CO2_emissions_data.R
	Rscript lengthen_CO2_emissions_data.R

