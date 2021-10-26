.PHONY: clean

clean:
	rm -f derived_data/*.csv

derived_data/long_CO2_emissions.csv: source_data/Air\ and\ Climate/CO2_emissions.csv lengthen_CO2_emissions_data.R
	Rscript lengthen_CO2_emissions_data.R

.PHONY: shiny_app
shiny_app: shiny_app.R
	Rscript shiny_app.R ${PORT}